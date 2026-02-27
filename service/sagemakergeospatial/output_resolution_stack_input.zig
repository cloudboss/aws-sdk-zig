const PredefinedResolution = @import("predefined_resolution.zig").PredefinedResolution;
const UserDefined = @import("user_defined.zig").UserDefined;

/// The input structure representing Output Resolution for Stacking Operation.
pub const OutputResolutionStackInput = struct {
    /// A string value representing Predefined Output Resolution for a stacking
    /// operation. Allowed values are `HIGHEST`, `LOWEST`, and `AVERAGE`.
    predefined: ?PredefinedResolution,

    /// The structure representing User Output Resolution for a Stacking operation
    /// defined as a value and unit.
    user_defined: ?UserDefined,

    pub const json_field_names = .{
        .predefined = "Predefined",
        .user_defined = "UserDefined",
    };
};
