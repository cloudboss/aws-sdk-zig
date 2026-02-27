const IndexCapacityConfiguration = @import("index_capacity_configuration.zig").IndexCapacityConfiguration;
const DocumentAttributeConfiguration = @import("document_attribute_configuration.zig").DocumentAttributeConfiguration;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const IndexStatistics = @import("index_statistics.zig").IndexStatistics;
const IndexStatus = @import("index_status.zig").IndexStatus;
const IndexType = @import("index_type.zig").IndexType;

pub const GetIndexResponse = struct {
    /// The identifier of the Amazon Q Business application associated with the
    /// index.
    application_id: ?[]const u8,

    /// The storage capacity units chosen for your Amazon Q Business index.
    capacity_configuration: ?IndexCapacityConfiguration,

    /// The Unix timestamp when the Amazon Q Business index was created.
    created_at: ?i64,

    /// The description for the Amazon Q Business index.
    description: ?[]const u8,

    /// The name of the Amazon Q Business index.
    display_name: ?[]const u8,

    /// Configuration information for document attributes or metadata. Document
    /// metadata are fields associated with your documents. For example, the company
    /// department name associated with each document. For more information, see
    /// [Understanding document
    /// attributes](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/doc-attributes-types.html#doc-attributes).
    document_attribute_configurations: ?[]const DocumentAttributeConfiguration,

    /// When the `Status` field value is `FAILED`, the `ErrorMessage` field contains
    /// a message that explains why.
    @"error": ?ErrorDetail,

    /// The Amazon Resource Name (ARN) of the Amazon Q Business index.
    index_arn: ?[]const u8,

    /// The identifier of the Amazon Q Business index.
    index_id: ?[]const u8,

    /// Provides information about the number of documents indexed.
    index_statistics: ?IndexStatistics,

    /// The current status of the index. When the value is `ACTIVE`, the index is
    /// ready for use. If the `Status` field value is `FAILED`, the `ErrorMessage`
    /// field contains a message that explains why.
    status: ?IndexStatus,

    /// The type of index attached to your Amazon Q Business application.
    type: ?IndexType,

    /// The Unix timestamp when the Amazon Q Business index was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .capacity_configuration = "capacityConfiguration",
        .created_at = "createdAt",
        .description = "description",
        .display_name = "displayName",
        .document_attribute_configurations = "documentAttributeConfigurations",
        .@"error" = "error",
        .index_arn = "indexArn",
        .index_id = "indexId",
        .index_statistics = "indexStatistics",
        .status = "status",
        .type = "type",
        .updated_at = "updatedAt",
    };
};
