/// Parameters used when defining a mitigation action that move a set of things
/// to a thing group.
pub const AddThingsToThingGroupParams = struct {
    /// Specifies if this mitigation action can move the things that triggered the
    /// mitigation action even if they are part of one or more dynamic thing groups.
    override_dynamic_groups: ?bool = null,

    /// The list of groups to which you want to add the things that triggered the
    /// mitigation action. You can add a thing to a maximum of 10 groups, but you
    /// can't add a thing to more than one group in the same hierarchy.
    thing_group_names: []const []const u8,

    pub const json_field_names = .{
        .override_dynamic_groups = "overrideDynamicGroups",
        .thing_group_names = "thingGroupNames",
    };
};
