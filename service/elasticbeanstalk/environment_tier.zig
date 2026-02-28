/// Describes the properties of an environment tier
pub const EnvironmentTier = struct {
    /// The name of this environment tier.
    ///
    /// Valid values:
    ///
    /// * For *Web server tier* – `WebServer`
    ///
    /// * For *Worker tier* – `Worker`
    name: ?[]const u8,

    /// The type of this environment tier.
    ///
    /// Valid values:
    ///
    /// * For *Web server tier* – `Standard`
    ///
    /// * For *Worker tier* – `SQS/HTTP`
    @"type": ?[]const u8,

    /// The version of this environment tier. When you don't set a value to it,
    /// Elastic Beanstalk uses the
    /// latest compatible worker tier version.
    ///
    /// This member is deprecated. Any specific version that you set may become out
    /// of date.
    /// We recommend leaving it unspecified.
    version: ?[]const u8,
};
