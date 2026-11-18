import Foundation
import PathKit
import Stencil
import StencilSwiftKit
import XCTest

final class TemplateSupportTests: XCTestCase {
    func testPathKitWritesAndReadsTemplateFiles() throws {
        let directory = Path(NSTemporaryDirectory()) + "PrefireTemplateSupport-\(UUID().uuidString)"
        defer { try? directory.delete() }

        try directory.mkpath()
        let template = directory + "example.stencil"
        try template.write("Hello {{ name }}")

        XCTAssertTrue(template.exists)
        XCTAssertEqual(try template.read(), "Hello {{ name }}")
        XCTAssertEqual(template.absolute(), template)
    }

    func testStencilRendersIncludesInheritanceAndWhitespaceControl() throws {
        let directory = Path(NSTemporaryDirectory()) + "PrefireTemplateSupport-\(UUID().uuidString)"
        defer { try? directory.delete() }

        try directory.mkpath()
        try (directory + "base.stencil").write("Header {% block body %}Base{% endblock %}")
        try (directory + "included.stencil").write("Included {{ name }}")
        try (directory + "child.stencil").write(
            "{% extends \"base.stencil\" %}{% block body %}{% include \"included.stencil\" %}{% endblock %}"
        )

        let environment = Environment(loader: FileSystemLoader(paths: [directory]))
        XCTAssertEqual(
            try environment.renderTemplate(name: "child.stencil", context: ["name": "Prefire"]),
            "Header Included Prefire"
        )

        let compact = Template(templateString: "{% for item in items -%}{{ item }}{%- endfor %}")
        XCTAssertEqual(try compact.render(["items": ["one", "two"]]), "onetwo")
    }

    func testStencilSwiftKitEnvironmentProvidesSwiftTemplateFilters() throws {
        let environment = stencilSwiftEnvironment()
        let template = "{{ identifier|lowerFirstLetter }}|{{ invalid|swiftIdentifier }}"

        XCTAssertEqual(
            try environment.renderTemplate(
                string: template,
                context: ["identifier": "PrefireGenerator", "invalid": "my value"]
            ),
            "prefireGenerator|My_Value"
        )
    }

    func testStencilReportsTemplateSyntaxErrors() {
        XCTAssertThrowsError(try Template(templateString: "{% if %}").render())
    }
}
