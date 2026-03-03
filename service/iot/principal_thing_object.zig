const ThingPrincipalType = @import("thing_principal_type.zig").ThingPrincipalType;

/// An object that represents the thing and the type of relation it has with the
/// principal.
pub const PrincipalThingObject = struct {
    /// The name of the thing.
    thing_name: []const u8,

    /// The type of the relation you want to specify when you attach a principal to
    /// a thing.
    /// The value defaults to `NON_EXCLUSIVE_THING`.
    ///
    /// * `EXCLUSIVE_THING` - Attaches the specified principal to the specified
    ///   thing, exclusively.
    /// The thing will be the only thing that’s attached to the principal.
    ///
    /// * `NON_EXCLUSIVE_THING` - Attaches the specified principal to the specified
    ///   thing.
    /// Multiple things can be attached to the principal.
    thing_principal_type: ?ThingPrincipalType = null,

    pub const json_field_names = .{
        .thing_name = "thingName",
        .thing_principal_type = "thingPrincipalType",
    };
};
