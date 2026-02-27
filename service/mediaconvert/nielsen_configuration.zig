/// Settings for your Nielsen configuration. If you don't do Nielsen measurement
/// and analytics, ignore these settings. When you enable Nielsen configuration,
/// MediaConvert enables PCM to ID3 tagging for all outputs in the job.
pub const NielsenConfiguration = struct {
    /// Nielsen has discontinued the use of breakout code functionality. If you must
    /// include this property, set the value to zero.
    breakout_code: ?i32,

    /// Use Distributor ID to specify the distributor ID that is assigned to your
    /// organization by Nielsen.
    distributor_id: ?[]const u8,

    pub const json_field_names = .{
        .breakout_code = "BreakoutCode",
        .distributor_id = "DistributorId",
    };
};
