const BotFilterName = @import("bot_filter_name.zig").BotFilterName;
const BotFilterOperator = @import("bot_filter_operator.zig").BotFilterOperator;

/// Filters the responses returned by the `ListBots`
/// operation.
pub const BotFilter = struct {
    /// The name of the field to filter the list of bots.
    name: BotFilterName,

    /// The operator to use for the filter. Specify `EQ` when the
    /// `ListBots` operation should return only aliases that
    /// equal the specified value. Specify `CO` when the
    /// `ListBots` operation should return aliases that contain
    /// the specified value.
    operator: BotFilterOperator,

    /// The value to use for filtering the list of bots.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
