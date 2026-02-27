const UserDefined = @import("user_defined.zig").UserDefined;

/// OutputResolution Configuration indicating
/// the target resolution for the output of Resampling operation.
pub const OutputResolutionResamplingInput = struct {
    /// User Defined Resolution for the output
    /// of Resampling operation defined by value and unit.
    user_defined: UserDefined,

    pub const json_field_names = .{
        .user_defined = "UserDefined",
    };
};
