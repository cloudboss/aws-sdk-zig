const OutputConfig = @import("output_config.zig").OutputConfig;
const OutputStatus = @import("output_status.zig").OutputStatus;

/// Contains configuration information about one output in a feed. It is used in
/// the UpdateFeed action.
pub const UpdateOutput = struct {
    /// A description of the output.
    description: ?[]const u8 = null,

    /// Elemental Inference originally sets this parameter to True if this output
    /// was created by AssociateFeed or to False if this output was created by
    /// CreateFeed or UpdateFeed.
    ///
    /// You must not change this value. Therefore, use GetFeed to determine the
    /// current value. Then in the UpdateFeed request, if the current value is True,
    /// include this parameter with a value of True. If it's False, omit the
    /// parameter.
    from_association: ?bool = null,

    /// The name of the output.
    name: []const u8,

    /// A typed property for an output in a feed. It identifies the action for
    /// Elemental Inference to perform. It also provides a repository for the
    /// results of that action. For example, CroppingConfig output will contain the
    /// metadata for the crop feature.
    output_config: OutputConfig,

    /// The status of the output.
    status: OutputStatus,

    pub const json_field_names = .{
        .description = "description",
        .from_association = "fromAssociation",
        .name = "name",
        .output_config = "outputConfig",
        .status = "status",
    };
};
