const AntennaDemodDecodeDetails = @import("antenna_demod_decode_details.zig").AntennaDemodDecodeDetails;
const EndpointDetails = @import("endpoint_details.zig").EndpointDetails;
const S3RecordingDetails = @import("s3_recording_details.zig").S3RecordingDetails;

/// Details for certain `Config` object types in a contact.
pub const ConfigDetails = union(enum) {
    /// Details for antenna demod decode `Config` in a contact.
    antenna_demod_decode_details: ?AntennaDemodDecodeDetails,
    endpoint_details: ?EndpointDetails,
    /// Details for an S3 recording `Config` in a contact.
    s_3_recording_details: ?S3RecordingDetails,

    pub const json_field_names = .{
        .antenna_demod_decode_details = "antennaDemodDecodeDetails",
        .endpoint_details = "endpointDetails",
        .s_3_recording_details = "s3RecordingDetails",
    };
};
