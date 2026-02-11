/// Specifies the action to add a new witness Region to a MRSC global table. A
/// MRSC global
/// table can be configured with either three replicas, or with two replicas and
/// one
/// witness.
pub const CreateGlobalTableWitnessGroupMemberAction = struct {
    /// The Amazon Web Services Region name to be added as a witness Region for the
    /// MRSC global
    /// table. The witness must be in a different Region than the replicas and
    /// within the same
    /// Region set:
    ///
    /// * US Region set: US East (N. Virginia), US East (Ohio), US West (Oregon)
    ///
    /// * EU Region set: Europe (Ireland), Europe (London), Europe (Paris), Europe
    /// (Frankfurt)
    ///
    /// * AP Region set: Asia Pacific (Tokyo), Asia Pacific (Seoul), Asia Pacific
    /// (Osaka)
    region_name: []const u8,

    pub const json_field_names = .{
        .region_name = "RegionName",
    };
};
