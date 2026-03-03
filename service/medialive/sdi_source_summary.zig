const SdiSourceMode = @import("sdi_source_mode.zig").SdiSourceMode;
const SdiSourceState = @import("sdi_source_state.zig").SdiSourceState;
const SdiSourceType = @import("sdi_source_type.zig").SdiSourceType;

/// Used in CreateSdiSourceResponse, DeleteSdiSourceResponse,
/// DescribeSdiSourceResponse, ListSdiSourcesResponse, UpdateSdiSourceResponse
pub const SdiSourceSummary = struct {
    /// The ARN of this SdiSource. It is automatically assigned when the SdiSource
    /// is created.
    arn: ?[]const u8 = null,

    /// The ID of the SdiSource. Unique in the AWS account.The ID is the resource-id
    /// portion of the ARN.
    id: ?[]const u8 = null,

    /// The list of inputs that are currently using this SDI source. This list will
    /// be empty if the SdiSource has just been deleted.
    inputs: ?[]const []const u8 = null,

    /// Applies only if the type is QUAD. The mode for handling the quad-link signal
    /// QUADRANT or INTERLEAVE.
    mode: ?SdiSourceMode = null,

    /// The name of the SdiSource.
    name: ?[]const u8 = null,

    /// Specifies whether the SDI source is attached to an SDI input (IN_USE) or not
    /// (IDLE).
    state: ?SdiSourceState = null,

    @"type": ?SdiSourceType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .inputs = "Inputs",
        .mode = "Mode",
        .name = "Name",
        .state = "State",
        .@"type" = "Type",
    };
};
