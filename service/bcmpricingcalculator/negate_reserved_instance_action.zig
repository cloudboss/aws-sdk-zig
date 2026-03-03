/// Represents an action to remove a Reserved Instance from a bill scenario.
///
/// This is the ID of an existing Reserved Instance in your account.
pub const NegateReservedInstanceAction = struct {
    /// The ID of the Reserved Instance to remove.
    reserved_instances_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .reserved_instances_id = "reservedInstancesId",
    };
};
