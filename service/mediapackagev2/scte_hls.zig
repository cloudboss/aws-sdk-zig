const AdMarkerHls = @import("ad_marker_hls.zig").AdMarkerHls;

/// The SCTE configuration.
pub const ScteHls = struct {
    /// Ad markers indicate when ads should be inserted during playback. If you
    /// include ad markers in the content stream in your upstream encoders, then you
    /// need to inform MediaPackage what to do with the ad markers in the output.
    /// Choose what you want MediaPackage to do with the ad markers.
    ///
    /// Value description:
    ///
    /// * SCTE35_ENHANCED - Generate industry-standard CUE tag ad markers in HLS
    ///   manifests based on SCTE-35 input messages from the input stream.
    /// * DATERANGE - Insert EXT-X-DATERANGE tags to signal ad and program
    ///   transition events in TS and CMAF manifests. If you use DATERANGE, you must
    ///   set a programDateTimeIntervalSeconds value of 1 or higher. To learn more
    ///   about DATERANGE, see [SCTE-35 Ad Marker
    ///   EXT-X-DATERANGE](http://docs.aws.amazon.com/mediapackage/latest/ug/scte-35-ad-marker-ext-x-daterange.html).
    ad_marker_hls: ?AdMarkerHls,

    pub const json_field_names = .{
        .ad_marker_hls = "AdMarkerHls",
    };
};
