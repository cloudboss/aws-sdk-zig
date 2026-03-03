const ThingPrincipalType = @import("thing_principal_type.zig").ThingPrincipalType;

/// An object that represents the principal and the type of relation it has with
/// the thing.
pub const ThingPrincipalObject = struct {
    /// The principal of the thing principal object.
    principal: []const u8,

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
        .principal = "principal",
        .thing_principal_type = "thingPrincipalType",
    };
};
