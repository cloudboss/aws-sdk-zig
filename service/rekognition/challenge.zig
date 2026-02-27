const ChallengeType = @import("challenge_type.zig").ChallengeType;

/// Describes the type and version of the challenge being used for the Face
/// Liveness session.
pub const Challenge = struct {
    /// The type of the challenge being used for the Face Liveness session.
    type: ChallengeType,

    /// The version of the challenge being used for the Face Liveness session.
    version: []const u8,

    pub const json_field_names = .{
        .type = "Type",
        .version = "Version",
    };
};
