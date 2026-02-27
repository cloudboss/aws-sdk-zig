const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const BenefitStatus = @import("benefit_status.zig").BenefitStatus;

/// A summary view of a benefit containing key information for list operations.
pub const BenefitSummary = struct {
    /// The Amazon Resource Name (ARN) of the benefit.
    arn: ?[]const u8,

    /// The catalog identifier that the benefit belongs to.
    catalog: ?[]const u8,

    /// A brief description of the benefit and its purpose.
    description: ?[]const u8,

    /// The available fulfillment types for this benefit.
    fulfillment_types: ?[]const FulfillmentType,

    /// The unique identifier of the benefit.
    id: ?[]const u8,

    /// The human-readable name of the benefit.
    name: ?[]const u8,

    /// The AWS partner programs that this benefit is associated with.
    programs: ?[]const []const u8,

    /// The current status of the benefit.
    status: ?BenefitStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .description = "Description",
        .fulfillment_types = "FulfillmentTypes",
        .id = "Id",
        .name = "Name",
        .programs = "Programs",
        .status = "Status",
    };
};
