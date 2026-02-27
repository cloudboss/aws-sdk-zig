const TemplateV2 = @import("template_v2.zig").TemplateV2;
const TemplateV3 = @import("template_v3.zig").TemplateV3;
const TemplateV4 = @import("template_v4.zig").TemplateV4;

/// Template configuration to define the information included in certificates.
/// Define
/// certificate validity and renewal periods, certificate request handling and
/// enrollment
/// options, key usage extensions, application policies, and cryptography
/// settings.
pub const TemplateDefinition = union(enum) {
    /// Template configuration to define the information included in certificates.
    /// Define
    /// certificate validity and renewal periods, certificate request handling and
    /// enrollment
    /// options, key usage extensions, application policies, and cryptography
    /// settings.
    template_v2: ?TemplateV2,
    /// Template configuration to define the information included in certificates.
    /// Define
    /// certificate validity and renewal periods, certificate request handling and
    /// enrollment
    /// options, key usage extensions, application policies, and cryptography
    /// settings.
    template_v3: ?TemplateV3,
    /// Template configuration to define the information included in certificates.
    /// Define
    /// certificate validity and renewal periods, certificate request handling and
    /// enrollment
    /// options, key usage extensions, application policies, and cryptography
    /// settings.
    template_v4: ?TemplateV4,

    pub const json_field_names = .{
        .template_v2 = "TemplateV2",
        .template_v3 = "TemplateV3",
        .template_v4 = "TemplateV4",
    };
};
