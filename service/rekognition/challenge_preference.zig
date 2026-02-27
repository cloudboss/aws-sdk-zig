const ChallengeType = @import("challenge_type.zig").ChallengeType;
const Versions = @import("versions.zig").Versions;

/// An ordered list of preferred challenge type and versions.
pub const ChallengePreference = struct {
    /// The types of challenges that have been selected for the Face Liveness
    /// session.
    type: ChallengeType,

    /// The version of the challenges that have been selected for the Face Liveness
    /// session.
    versions: ?Versions,

    pub const json_field_names = .{
        .type = "Type",
        .versions = "Versions",
    };
};
