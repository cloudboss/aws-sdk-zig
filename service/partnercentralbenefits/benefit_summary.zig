const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const BenefitStatus = @import("benefit_status.zig").BenefitStatus;

/// A summary view of a benefit containing key information for list operations.
pub const BenefitSummary = struct {
    /// The Amazon Resource Name (ARN) of the benefit.
    arn: ?[]const u8 = null,

    /// The catalog identifier that the benefit belongs to.
    catalog: ?[]const u8 = null,

    /// A brief description of the benefit and its purpose.
    description: ?[]const u8 = null,

    /// The available fulfillment types for this benefit.
    fulfillment_types: ?[]const FulfillmentType = null,

    /// The unique identifier of the benefit.
    id: ?[]const u8 = null,

    /// The human-readable name of the benefit.
    name: ?[]const u8 = null,

    /// The AWS partner programs that this benefit is associated with.
    programs: ?[]const []const u8 = null,

    /// The current status of the benefit.
    status: ?BenefitStatus = null,

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
