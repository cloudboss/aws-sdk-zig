const Telemetry = @import("telemetry.zig").Telemetry;

/// This structure contains much of the configuration data for the app monitor.
pub const AppMonitorConfiguration = struct {
    /// If you set this to `true`, the RUM web client sets two cookies, a session
    /// cookie and a user cookie. The cookies allow the RUM web client to collect
    /// data relating to the number of users an application has and the behavior of
    /// the application across a sequence of events. Cookies are stored in the
    /// top-level domain of the current page.
    allow_cookies: ?bool,

    /// If you set this to `true`, RUM enables X-Ray tracing for the user sessions
    /// that RUM samples. RUM adds an X-Ray trace header to allowed HTTP requests.
    /// It also records an X-Ray segment for allowed HTTP requests. You can see
    /// traces and segments from these user sessions in the X-Ray console and the
    /// CloudWatch ServiceLens console. For more information, see [What is
    /// X-Ray?](https://docs.aws.amazon.com/xray/latest/devguide/aws-xray.html)
    enable_x_ray: ?bool,

    /// A list of URLs in your website or application to exclude from RUM data
    /// collection.
    ///
    /// You can't include both `ExcludedPages` and `IncludedPages` in the same
    /// operation.
    excluded_pages: ?[]const []const u8,

    /// A list of pages in your application that are to be displayed with a
    /// "favorite" icon in the CloudWatch RUM console.
    favorite_pages: ?[]const []const u8,

    /// The ARN of the guest IAM role that is attached to the Amazon Cognito
    /// identity pool that is used to authorize the sending of data to RUM.
    ///
    /// It is possible that an app monitor does not have a value for `GuestRoleArn`.
    /// For example, this can happen when you use the console to create an app
    /// monitor and you allow CloudWatch RUM to create a new identity pool for
    /// Authorization. In this case, `GuestRoleArn` is not present in the
    /// [GetAppMonitor](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_GetAppMonitor.html) response because it is not stored by the service.
    ///
    /// If this issue affects you, you can take one of the following steps:
    ///
    /// * Use the Cloud Development Kit (CDK) to create an identity pool and the
    ///   associated IAM role, and use that for your app monitor.
    /// * Make a separate
    ///   [GetIdentityPoolRoles](https://docs.aws.amazon.com/cognitoidentity/latest/APIReference/API_GetIdentityPoolRoles.html) call to Amazon Cognito to retrieve the `GuestRoleArn`.
    guest_role_arn: ?[]const u8,

    /// The ID of the Amazon Cognito identity pool that is used to authorize the
    /// sending of data to RUM.
    identity_pool_id: ?[]const u8,

    /// If this app monitor is to collect data from only certain pages in your
    /// application, this structure lists those pages.
    ///
    /// You can't include both `ExcludedPages` and `IncludedPages` in the same
    /// operation.
    included_pages: ?[]const []const u8,

    /// Specifies the portion of user sessions to use for RUM data collection.
    /// Choosing a higher portion gives you more data but also incurs more costs.
    ///
    /// The range for this value is 0 to 1 inclusive. Setting this to 1 means that
    /// 100% of user sessions are sampled, and setting it to 0.1 means that 10% of
    /// user sessions are sampled.
    ///
    /// If you omit this parameter, the default of 0.1 is used, and 10% of sessions
    /// will be sampled.
    session_sample_rate: f64 = 0,

    /// An array that lists the types of telemetry data that this app monitor is to
    /// collect.
    ///
    /// * `errors` indicates that RUM collects data about unhandled JavaScript
    ///   errors raised by your application.
    /// * `performance` indicates that RUM collects performance data about how your
    ///   application and its resources are loaded and rendered. This includes Core
    ///   Web Vitals.
    /// * `http` indicates that RUM collects data about HTTP errors thrown by your
    ///   application.
    telemetries: ?[]const Telemetry,

    pub const json_field_names = .{
        .allow_cookies = "AllowCookies",
        .enable_x_ray = "EnableXRay",
        .excluded_pages = "ExcludedPages",
        .favorite_pages = "FavoritePages",
        .guest_role_arn = "GuestRoleArn",
        .identity_pool_id = "IdentityPoolId",
        .included_pages = "IncludedPages",
        .session_sample_rate = "SessionSampleRate",
        .telemetries = "Telemetries",
    };
};
