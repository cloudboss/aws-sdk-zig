const BotLocaleFilterName = @import("bot_locale_filter_name.zig").BotLocaleFilterName;
const BotLocaleFilterOperator = @import("bot_locale_filter_operator.zig").BotLocaleFilterOperator;

/// Filters responses returned by the `ListBotLocales`
/// operation.
pub const BotLocaleFilter = struct {
    /// The name of the field to filter the list of bots.
    name: BotLocaleFilterName,

    /// The operator to use for the filter. Specify `EQ` when the
    /// `ListBotLocales` operation should return only aliases
    /// that equal the specified value. Specify `CO` when the
    /// `ListBotLocales` operation should return aliases that
    /// contain the specified value.
    operator: BotLocaleFilterOperator,

    /// The value to use for filtering the list of bots.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
