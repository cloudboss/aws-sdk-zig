/// Usage-specific statistics about the domain.
pub const DomainStats = struct {
    /// The number of profiles that you are currently paying for in the domain. If
    /// you have more
    /// than 100 objects associated with a single profile, that profile counts as
    /// two profiles. If
    /// you have more than 200 objects, that profile counts as three, and so on.
    metering_profile_count: i64 = 0,

    /// The total number of objects in domain.
    object_count: i64 = 0,

    /// The total number of profiles currently in the domain.
    profile_count: i64 = 0,

    /// The total size, in bytes, of all objects in the domain.
    total_size: i64 = 0,

    pub const json_field_names = .{
        .metering_profile_count = "MeteringProfileCount",
        .object_count = "ObjectCount",
        .profile_count = "ProfileCount",
        .total_size = "TotalSize",
    };
};
