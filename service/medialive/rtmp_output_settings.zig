const RtmpOutputCertificateMode = @import("rtmp_output_certificate_mode.zig").RtmpOutputCertificateMode;
const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;

/// Rtmp Output Settings
pub const RtmpOutputSettings = struct {
    /// If set to verifyAuthenticity, verify the tls certificate chain to a trusted
    /// Certificate Authority (CA). This will cause rtmps outputs with self-signed
    /// certificates to fail.
    certificate_mode: ?RtmpOutputCertificateMode,

    /// Number of seconds to wait before retrying a connection to the Flash Media
    /// server if the connection is lost.
    connection_retry_interval: ?i32,

    /// The RTMP endpoint excluding the stream name (eg. rtmp://host/appname). For
    /// connection to Akamai, a username and password must be supplied. URI fields
    /// accept format identifiers.
    destination: OutputLocationRef,

    /// Number of retry attempts.
    num_retries: ?i32,

    pub const json_field_names = .{
        .certificate_mode = "CertificateMode",
        .connection_retry_interval = "ConnectionRetryInterval",
        .destination = "Destination",
        .num_retries = "NumRetries",
    };
};
