const Mode = @import("mode.zig").Mode;

/// Specifies settings for invoking an AWS Lambda function that customizes a
/// segment for a campaign.
pub const CampaignHook = struct {
    /// The name or Amazon Resource Name (ARN) of the AWS Lambda function that
    /// Amazon Pinpoint invokes to customize a segment for a campaign.
    lambda_function_name: ?[]const u8 = null,

    /// The mode that Amazon Pinpoint uses to invoke the AWS Lambda function.
    /// Possible values are:
    ///
    /// * FILTER - Invoke the function to customize the segment that's used by a
    ///   campaign.
    /// * DELIVERY - (Deprecated) Previously, invoked the function to send a
    ///   campaign through a custom channel. This functionality is not supported
    ///   anymore. To send a campaign through a custom channel, use the
    ///   CustomDeliveryConfiguration and CampaignCustomMessage objects of the
    ///   campaign.
    mode: ?Mode = null,

    /// The web URL that Amazon Pinpoint calls to invoke the AWS Lambda function
    /// over HTTPS.
    web_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .lambda_function_name = "LambdaFunctionName",
        .mode = "Mode",
        .web_url = "WebUrl",
    };
};
