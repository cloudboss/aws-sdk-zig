const aws = @import("aws");

const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const BenefitApplicationStatus = @import("benefit_application_status.zig").BenefitApplicationStatus;

/// A summary view of a benefit application containing key information for list
/// operations.
pub const BenefitApplicationSummary = struct {
    /// The Amazon Resource Name (ARN) of the benefit application.
    arn: ?[]const u8,

    /// AWS resources that are associated with this benefit application.
    associated_resources: ?[]const []const u8,

    /// Additional attributes and metadata associated with the benefit application.
    benefit_application_details: ?[]const aws.map.StringMapEntry,

    /// The identifier of the benefit being requested in this application.
    benefit_id: ?[]const u8,

    /// The catalog identifier that the benefit application belongs to.
    catalog: ?[]const u8,

    /// The timestamp when the benefit application was created.
    created_at: ?i64,

    /// The fulfillment types requested for this benefit application.
    fulfillment_types: ?[]const FulfillmentType,

    /// The unique identifier of the benefit application.
    id: ?[]const u8,

    /// The human-readable name of the benefit application.
    name: ?[]const u8,

    /// The AWS partner programs associated with this benefit application.
    programs: ?[]const []const u8,

    /// The current stage in the benefit application processing workflow..
    stage: ?[]const u8,

    /// The current processing status of the benefit application.
    status: ?BenefitApplicationStatus,

    /// The timestamp when the benefit application was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_resources = "AssociatedResources",
        .benefit_application_details = "BenefitApplicationDetails",
        .benefit_id = "BenefitId",
        .catalog = "Catalog",
        .created_at = "CreatedAt",
        .fulfillment_types = "FulfillmentTypes",
        .id = "Id",
        .name = "Name",
        .programs = "Programs",
        .stage = "Stage",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
