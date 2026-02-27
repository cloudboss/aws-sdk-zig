const Condition = @import("condition.zig").Condition;
const TargetListType = @import("target_list_type.zig").TargetListType;

/// A leaf node condition which can be used to specify a List condition to
/// search users with attributes included in
/// Lists like Proficiencies.
pub const ListCondition = struct {
    /// A list of Condition objects which would be applied together with an AND
    /// condition.
    conditions: ?[]const Condition,

    /// The type of target list that will be used to filter the users.
    target_list_type: ?TargetListType,

    pub const json_field_names = .{
        .conditions = "Conditions",
        .target_list_type = "TargetListType",
    };
};
