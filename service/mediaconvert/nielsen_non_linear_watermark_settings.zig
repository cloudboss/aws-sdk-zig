const NielsenActiveWatermarkProcessType = @import("nielsen_active_watermark_process_type.zig").NielsenActiveWatermarkProcessType;
const NielsenSourceWatermarkStatusType = @import("nielsen_source_watermark_status_type.zig").NielsenSourceWatermarkStatusType;
const NielsenUniqueTicPerAudioTrackType = @import("nielsen_unique_tic_per_audio_track_type.zig").NielsenUniqueTicPerAudioTrackType;

/// Ignore these settings unless you are using Nielsen non-linear watermarking.
/// Specify the values that MediaConvert uses to generate and place Nielsen
/// watermarks in your output audio. In addition to specifying these values, you
/// also need to set up your cloud TIC server. These settings apply to every
/// output in your job. The MediaConvert implementation is currently with the
/// following Nielsen versions: Nielsen Watermark SDK Version 6.0.13 Nielsen NLM
/// Watermark Engine Version 1.3.3 Nielsen Watermark Authenticator [SID_TIC]
/// Version [7.0.0]
pub const NielsenNonLinearWatermarkSettings = struct {
    /// Choose the type of Nielsen watermarks that you want in your outputs. When
    /// you choose NAES 2 and NW, you must provide a value for the setting SID. When
    /// you choose CBET, you must provide a value for the setting CSID. When you
    /// choose NAES 2, NW, and CBET, you must provide values for both of these
    /// settings.
    active_watermark_process: ?NielsenActiveWatermarkProcessType,

    /// Optional. Use this setting when you want the service to include an ADI file
    /// in the Nielsen metadata .zip file. To provide an ADI file, store it in
    /// Amazon S3 and provide a URL to it here. The URL should be in the following
    /// format: S3://bucket/path/ADI-file. For more information about the metadata
    /// .zip file, see the setting Metadata destination.
    adi_filename: ?[]const u8,

    /// Use the asset ID that you provide to Nielsen to uniquely identify this
    /// asset. Required for all Nielsen non-linear watermarking.
    asset_id: ?[]const u8,

    /// Use the asset name that you provide to Nielsen for this asset. Required for
    /// all Nielsen non-linear watermarking.
    asset_name: ?[]const u8,

    /// Use the CSID that Nielsen provides to you. This CBET source ID should be
    /// unique to your Nielsen account but common to all of your output assets that
    /// have CBET watermarking. Required when you choose a value for the setting
    /// Watermark types that includes CBET.
    cbet_source_id: ?[]const u8,

    /// Optional. If this asset uses an episode ID with Nielsen, provide it here.
    episode_id: ?[]const u8,

    /// Specify the Amazon S3 location where you want MediaConvert to save your
    /// Nielsen non-linear metadata .zip file. This Amazon S3 bucket must be in the
    /// same Region as the one where you do your MediaConvert transcoding. If you
    /// want to include an ADI file in this .zip file, use the setting ADI file to
    /// specify it. MediaConvert delivers the Nielsen metadata .zip files only to
    /// your metadata destination Amazon S3 bucket. It doesn't deliver the .zip
    /// files to Nielsen. You are responsible for delivering the metadata .zip files
    /// to Nielsen.
    metadata_destination: ?[]const u8,

    /// Use the SID that Nielsen provides to you. This source ID should be unique to
    /// your Nielsen account but common to all of your output assets. Required for
    /// all Nielsen non-linear watermarking. This ID should be unique to your
    /// Nielsen account but common to all of your output assets. Required for all
    /// Nielsen non-linear watermarking.
    source_id: ?i32,

    /// Required. Specify whether your source content already contains Nielsen
    /// non-linear watermarks. When you set this value to Watermarked, the service
    /// fails the job. Nielsen requires that you add non-linear watermarking to only
    /// clean content that doesn't already have non-linear Nielsen watermarks.
    source_watermark_status: ?NielsenSourceWatermarkStatusType,

    /// Specify the endpoint for the TIC server that you have deployed and
    /// configured in the AWS Cloud. Required for all Nielsen non-linear
    /// watermarking. MediaConvert can't connect directly to a TIC server. Instead,
    /// you must use API Gateway to provide a RESTful interface between MediaConvert
    /// and a TIC server that you deploy in your AWS account. For more information
    /// on deploying a TIC server in your AWS account and the required API Gateway,
    /// contact Nielsen support.
    tic_server_url: ?[]const u8,

    /// To create assets that have the same TIC values in each audio track, keep the
    /// default value Share TICs. To create assets that have unique TIC values for
    /// each audio track, choose Use unique TICs.
    unique_tic_per_audio_track: ?NielsenUniqueTicPerAudioTrackType,

    pub const json_field_names = .{
        .active_watermark_process = "ActiveWatermarkProcess",
        .adi_filename = "AdiFilename",
        .asset_id = "AssetId",
        .asset_name = "AssetName",
        .cbet_source_id = "CbetSourceId",
        .episode_id = "EpisodeId",
        .metadata_destination = "MetadataDestination",
        .source_id = "SourceId",
        .source_watermark_status = "SourceWatermarkStatus",
        .tic_server_url = "TicServerUrl",
        .unique_tic_per_audio_track = "UniqueTicPerAudioTrack",
    };
};
