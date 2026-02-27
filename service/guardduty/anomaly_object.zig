const Observations = @import("observations.zig").Observations;
const ProfileSubtype = @import("profile_subtype.zig").ProfileSubtype;
const ProfileType = @import("profile_type.zig").ProfileType;

/// Contains information about the unusual anomalies.
pub const AnomalyObject = struct {
    /// The recorded value.
    observations: ?Observations,

    /// The frequency of the anomaly.
    profile_subtype: ?ProfileSubtype,

    /// The type of behavior of the profile.
    profile_type: ?ProfileType,

    pub const json_field_names = .{
        .observations = "Observations",
        .profile_subtype = "ProfileSubtype",
        .profile_type = "ProfileType",
    };
};
