const OutputConfig = @import("output_config.zig").OutputConfig;
const OutputStatus = @import("output_status.zig").OutputStatus;

/// Contains configuration information about one output in a feed. It is used in
/// the GetFeed response.
pub const GetOutput = struct {
    /// The description of the output.
    description: ?[]const u8 = null,

    /// True means that the output was originally created in the feed using
    /// AssociateFeed. False means it was created using CreateFeed or UpdateFeed.
    ///
    /// You will need this value if you use UpdateFeed to modify the list of outputs
    /// in the feed.
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
