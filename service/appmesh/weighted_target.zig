/// An object that represents a target and its relative weight. Traffic is
/// distributed
/// across targets according to their relative weight. For example, a weighted
/// target with a
/// relative weight of 50 receives five times as much traffic as one with a
/// relative weight of
/// 10. The total weight for all targets combined must be less than or equal to
/// 100.
pub const WeightedTarget = struct {
    /// The targeted port of the weighted object.
    port: ?i32 = null,

    /// The virtual node to associate with the weighted target.
    virtual_node: []const u8,

    /// The relative weight of the weighted target.
    weight: i32 = 0,

    pub const json_field_names = .{
        .port = "port",
        .virtual_node = "virtualNode",
        .weight = "weight",
    };
};
