const Destination = @import("destination.zig").Destination;
const SigningProfileParameter = @import("signing_profile_parameter.zig").SigningProfileParameter;

/// Information required to start a signing job.
pub const StartSigningJobParameter = struct {
    /// The location to write the code-signed file.
    destination: ?Destination = null,

    /// The code-signing profile name.
    signing_profile_name: ?[]const u8 = null,

    /// Describes the code-signing profile.
    signing_profile_parameter: ?SigningProfileParameter = null,

    pub const json_field_names = .{
        .destination = "destination",
        .signing_profile_name = "signingProfileName",
        .signing_profile_parameter = "signingProfileParameter",
    };
};
