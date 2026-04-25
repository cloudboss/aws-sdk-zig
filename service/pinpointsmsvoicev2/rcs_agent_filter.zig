const RcsAgentFilterName = @import("rcs_agent_filter_name.zig").RcsAgentFilterName;

/// The information for an RCS agent that meets a specified criteria.
pub const RcsAgentFilter = struct {
    /// The name of the attribute to filter on.
    name: RcsAgentFilterName,

    /// An array values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
