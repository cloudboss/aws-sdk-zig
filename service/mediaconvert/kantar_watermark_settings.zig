/// Use these settings only when you use Kantar watermarking. Specify the values
/// that MediaConvert uses to generate and place Kantar watermarks in your
/// output audio. These settings apply to every output in your job. In addition
/// to specifying these values, you also need to store your Kantar credentials
/// in AWS Secrets Manager. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/kantar-watermarking.html.
pub const KantarWatermarkSettings = struct {
    /// Provide an audio channel name from your Kantar audio license.
    channel_name: ?[]const u8,

    /// Specify a unique identifier for Kantar to use for this piece of content.
    content_reference: ?[]const u8,

    /// Provide the name of the AWS Secrets Manager secret where your Kantar
    /// credentials are stored. Note that your MediaConvert service role must
    /// provide access to this secret. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/granting-permissions-for-mediaconvert-to-access-secrets-manager-secret.html. For instructions on creating a secret, see https://docs.aws.amazon.com/secretsmanager/latest/userguide/tutorials_basic.html, in the AWS Secrets Manager User Guide.
    credentials_secret_name: ?[]const u8,

    /// Optional. Specify an offset, in whole seconds, from the start of your output
    /// and the beginning of the watermarking. When you don't specify an offset,
    /// Kantar defaults to zero.
    file_offset: ?f64,

    /// Provide your Kantar license ID number. You should get this number from
    /// Kantar.
    kantar_license_id: ?i32,

    /// Provide the HTTPS endpoint to the Kantar server. You should get this
    /// endpoint from Kantar.
    kantar_server_url: ?[]const u8,

    /// Optional. Specify the Amazon S3 bucket where you want MediaConvert to store
    /// your Kantar watermark XML logs. When you don't specify a bucket,
    /// MediaConvert doesn't save these logs. Note that your MediaConvert service
    /// role must provide access to this location. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/iam-role.html
    log_destination: ?[]const u8,

    /// You can optionally use this field to specify the first timestamp that Kantar
    /// embeds during watermarking. Kantar suggests that you be very cautious when
    /// using this Kantar feature, and that you use it only on channels that are
    /// managed specifically for use with this feature by your Audience Measurement
    /// Operator. For more information about this feature, contact Kantar technical
    /// support.
    metadata_3: ?[]const u8,

    /// Additional metadata that MediaConvert sends to Kantar. Maximum length is 50
    /// characters.
    metadata_4: ?[]const u8,

    /// Additional metadata that MediaConvert sends to Kantar. Maximum length is 50
    /// characters.
    metadata_5: ?[]const u8,

    /// Additional metadata that MediaConvert sends to Kantar. Maximum length is 50
    /// characters.
    metadata_6: ?[]const u8,

    /// Additional metadata that MediaConvert sends to Kantar. Maximum length is 50
    /// characters.
    metadata_7: ?[]const u8,

    /// Additional metadata that MediaConvert sends to Kantar. Maximum length is 50
    /// characters.
    metadata_8: ?[]const u8,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .content_reference = "ContentReference",
        .credentials_secret_name = "CredentialsSecretName",
        .file_offset = "FileOffset",
        .kantar_license_id = "KantarLicenseId",
        .kantar_server_url = "KantarServerUrl",
        .log_destination = "LogDestination",
        .metadata_3 = "Metadata3",
        .metadata_4 = "Metadata4",
        .metadata_5 = "Metadata5",
        .metadata_6 = "Metadata6",
        .metadata_7 = "Metadata7",
        .metadata_8 = "Metadata8",
    };
};
