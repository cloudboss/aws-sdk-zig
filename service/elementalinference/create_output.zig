const OutputConfig = @import("output_config.zig").OutputConfig;
const OutputStatus = @import("output_status.zig").OutputStatus;

/// Contains configuration information about one output in a feed. It is used in
/// the AssociateFeed and the CreateFeed actions.
pub const CreateOutput = struct {
    /// A description for the output.
    description: ?[]const u8 = null,

    /// A name for the output.
    name: []const u8,

    /// A typed property for an output in a feed. It identifies the action for
    /// Elemental Inference to perform. It also provides a repository for the
    /// results of that action. For example, CroppingConfig output will contain the
    /// metadata for the crop feature.
    output_config: OutputConfig,

    /// The status to assign to the output.
    status: OutputStatus,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .output_config = "outputConfig",
        .status = "status",
    };
};
