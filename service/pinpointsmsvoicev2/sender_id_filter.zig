const SenderIdFilterName = @import("sender_id_filter_name.zig").SenderIdFilterName;

/// The information for a sender ID that meets a specified criteria.
pub const SenderIdFilter = struct {
    /// The name of the attribute to filter on.
    name: SenderIdFilterName,

    /// An array of values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
