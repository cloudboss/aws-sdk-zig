const VisualCustomActionDefaults = @import("visual_custom_action_defaults.zig").VisualCustomActionDefaults;
const QBusinessInsightsStatus = @import("q_business_insights_status.zig").QBusinessInsightsStatus;
const VisualMessages = @import("visual_messages.zig").VisualMessages;
const DayOfTheWeek = @import("day_of_the_week.zig").DayOfTheWeek;

/// An array of analysis level configurations.
pub const AssetOptions = struct {
    /// A list of visual custom actions for the analysis.
    custom_action_defaults: ?VisualCustomActionDefaults = null,

    /// A list of dataset ARNS to exclude from Dashboard Q&A.
    excluded_data_set_arns: ?[]const []const u8 = null,

    /// Determines whether insight summaries from Amazon Q Business are allowed in
    /// Dashboard Q&A.
    q_business_insights_status: ?QBusinessInsightsStatus = null,

    /// Determines the timezone for the analysis.
    timezone: ?[]const u8 = null,

    /// The configuration options for the messages that are displayed on visuals in
    /// the analysis.
    visual_messages: ?VisualMessages = null,

    /// Determines the week start day for an analysis.
    week_start: ?DayOfTheWeek = null,

    pub const json_field_names = .{
        .custom_action_defaults = "CustomActionDefaults",
        .excluded_data_set_arns = "ExcludedDataSetArns",
        .q_business_insights_status = "QBusinessInsightsStatus",
        .timezone = "Timezone",
        .visual_messages = "VisualMessages",
        .week_start = "WeekStart",
    };
};
