const SourceProcessingProperties = @import("source_processing_properties.zig").SourceProcessingProperties;
const TargetProcessingProperties = @import("target_processing_properties.zig").TargetProcessingProperties;

/// A structure representing an integration resource property.
pub const IntegrationResourceProperty = struct {
    /// The connection ARN of the source, or the database ARN of the target.
    resource_arn: []const u8,

    /// The resource ARN created through this create API. The format is something
    /// like arn:aws:glue:::integrationresourceproperty/*
    resource_property_arn: ?[]const u8 = null,

    /// The resource properties associated with the integration source.
    source_processing_properties: ?SourceProcessingProperties = null,

    /// The resource properties associated with the integration target.
    target_processing_properties: ?TargetProcessingProperties = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_property_arn = "ResourcePropertyArn",
        .source_processing_properties = "SourceProcessingProperties",
        .target_processing_properties = "TargetProcessingProperties",
    };
};
