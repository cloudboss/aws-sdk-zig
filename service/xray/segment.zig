/// A segment from a trace that has been ingested by the X-Ray service. The
/// segment can be
/// compiled from documents uploaded with
/// [PutTraceSegments](https://docs.aws.amazon.com/xray/latest/api/API_PutTraceSegments.html), or an
/// `inferred` segment for a downstream service, generated from a subsegment
/// sent by
/// the service that called it.
///
/// For the full segment document schema, see [Amazon Web Services X-Ray segment
/// documents](https://docs.aws.amazon.com/xray/latest/devguide/aws-xray-interface-api.html#xray-api-segmentdocuments) in the *Amazon Web Services X-Ray Developer Guide*.
pub const Segment = struct {
    /// The segment document.
    document: ?[]const u8,

    /// The segment's ID.
    id: ?[]const u8,

    pub const json_field_names = .{
        .document = "Document",
        .id = "Id",
    };
};
