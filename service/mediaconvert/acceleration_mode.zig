/// Specify whether the service runs your job with accelerated transcoding.
/// Choose DISABLED if you don't want accelerated transcoding. Choose ENABLED if
/// you want your job to run with accelerated transcoding and to fail if your
/// input files or your job settings aren't compatible with accelerated
/// transcoding. Choose PREFERRED if you want your job to run with accelerated
/// transcoding if the job is compatible with the feature and to run at standard
/// speed if it's not.
pub const AccelerationMode = enum {
    disabled,
    enabled,
    preferred,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .preferred = "PREFERRED",
    };
};
