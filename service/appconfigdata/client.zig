const aws = @import("aws");
const std = @import("std");

const get_latest_configuration = @import("get_latest_configuration.zig");
const start_configuration_session = @import("start_configuration_session.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AppConfigData";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Retrieves the latest deployed configuration. This API may return empty
    /// configuration
    /// data if the client already has the latest version. For more information
    /// about this API
    /// action and to view example CLI commands that show how to use it with the
    /// StartConfigurationSession API action, see [Retrieving the
    /// configuration](http://docs.aws.amazon.com/appconfig/latest/userguide/appconfig-retrieving-the-configuration) in the *AppConfig User Guide*.
    ///
    /// Note the following important information.
    ///
    /// * Each configuration token is only valid for one call to
    /// `GetLatestConfiguration`. The `GetLatestConfiguration`
    /// response includes a `NextPollConfigurationToken` that should always
    /// replace the token used for the just-completed call in preparation for the
    /// next
    /// one.
    ///
    /// * `GetLatestConfiguration` is a priced call. For more information, see
    /// [Pricing](https://aws.amazon.com/systems-manager/pricing/).
    pub fn getLatestConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_latest_configuration.GetLatestConfigurationInput, options: get_latest_configuration.Options) !get_latest_configuration.GetLatestConfigurationOutput {
        return get_latest_configuration.execute(self, allocator, input, options);
    }

    /// Starts a configuration session used to retrieve a deployed configuration.
    /// For more
    /// information about this API action and to view example CLI commands that show
    /// how to use
    /// it with the GetLatestConfiguration API action, see [Retrieving the
    /// configuration](http://docs.aws.amazon.com/appconfig/latest/userguide/appconfig-retrieving-the-configuration) in the *AppConfig User Guide*.
    pub fn startConfigurationSession(self: *Self, allocator: std.mem.Allocator, input: start_configuration_session.StartConfigurationSessionInput, options: start_configuration_session.Options) !start_configuration_session.StartConfigurationSessionOutput {
        return start_configuration_session.execute(self, allocator, input, options);
    }
};
