const InputType = @import("input_type.zig").InputType;
const Rule = @import("rule.zig").Rule;
const Tag = @import("tag.zig").Tag;

/// Provides you with the properties of the Call Analytics category you
/// specified in your
/// request. This includes the list of rules that define the specified category.
pub const CategoryProperties = struct {
    /// The name of the Call Analytics category. Category names are case sensitive
    /// and must be
    /// unique within an Amazon Web Services account.
    category_name: ?[]const u8,

    /// The date and time the specified Call Analytics category was created.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents 12:32 PM UTC-7 on May
    /// 4, 2022.
    create_time: ?i64,

    /// The input type associated with the specified category. `POST_CALL`
    /// refers to a category that is applied to batch transcriptions; `REAL_TIME`
    /// refers to a category that is applied to streaming transcriptions.
    input_type: ?InputType,

    /// The date and time the specified Call Analytics category was last updated.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-05T12:45:32.691000-07:00` represents 12:45 PM UTC-7 on May
    /// 5, 2022.
    last_update_time: ?i64,

    /// The rules used to define a Call Analytics category. Each category can have
    /// between 1
    /// and 20 rules.
    rules: ?[]const Rule,

    /// The tags, each in the form of a key:value pair, assigned to the specified
    /// call analytics category.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .category_name = "CategoryName",
        .create_time = "CreateTime",
        .input_type = "InputType",
        .last_update_time = "LastUpdateTime",
        .rules = "Rules",
        .tags = "Tags",
    };
};
