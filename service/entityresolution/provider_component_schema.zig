const ProviderSchemaAttribute = @import("provider_schema_attribute.zig").ProviderSchemaAttribute;

/// The input schema supported by provider service.
pub const ProviderComponentSchema = struct {
    /// The provider schema attributes.
    provider_schema_attributes: ?[]const ProviderSchemaAttribute = null,

    /// Input schema for the provider service.
    schemas: ?[]const []const []const u8 = null,

    pub const json_field_names = .{
        .provider_schema_attributes = "providerSchemaAttributes",
        .schemas = "schemas",
    };
};
