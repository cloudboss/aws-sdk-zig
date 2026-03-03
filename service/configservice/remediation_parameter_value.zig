const ResourceValue = @import("resource_value.zig").ResourceValue;
const StaticValue = @import("static_value.zig").StaticValue;

/// The value is either a dynamic (resource) value or a static value. You must
/// select either a dynamic value or a static value.
pub const RemediationParameterValue = struct {
    /// The value is dynamic and changes at run-time.
    resource_value: ?ResourceValue = null,

    /// The value is static and does not change at run-time.
    static_value: ?StaticValue = null,

    pub const json_field_names = .{
        .resource_value = "ResourceValue",
        .static_value = "StaticValue",
    };
};
