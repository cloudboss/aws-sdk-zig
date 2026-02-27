/// Specifies the weights for the share identifiers for the fair-share policy.
/// Share
/// identifiers that aren't included have a default weight of `1.0`.
pub const ShareAttributes = struct {
    /// A share identifier or share identifier prefix. If the string ends with an
    /// asterisk
    /// (*), this entry specifies the weight factor to use for share identifiers
    /// that start with
    /// that prefix. The list of share identifiers in a fair-share policy can't
    /// overlap. For
    /// example, you can't have one that specifies a `shareIdentifier` of `UserA*`
    /// and another that specifies a `shareIdentifier` of `UserA1`.
    ///
    /// There can be no more than 500 share identifiers active in a job queue.
    ///
    /// The string is limited to 255 alphanumeric characters, and can be followed by
    /// an asterisk
    /// (*).
    share_identifier: []const u8,

    /// The weight factor for the share identifier. The default value is 1.0. A
    /// lower value has
    /// a higher priority for compute resources. For example, jobs that use a share
    /// identifier with a
    /// weight factor of 0.125 (1/8) get 8 times the compute resources of jobs that
    /// use a share
    /// identifier with a weight factor of 1.
    ///
    /// The smallest supported value is 0.0001, and the largest supported value is
    /// 999.9999.
    weight_factor: ?f32,

    pub const json_field_names = .{
        .share_identifier = "shareIdentifier",
        .weight_factor = "weightFactor",
    };
};
