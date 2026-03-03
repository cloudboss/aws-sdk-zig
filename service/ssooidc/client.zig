const aws = @import("aws");
const std = @import("std");

const create_token = @import("create_token.zig");
const create_token_with_iam = @import("create_token_with_iam.zig");
const register_client = @import("register_client.zig");
const start_device_authorization = @import("start_device_authorization.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SSO OIDC";

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

    /// Creates and returns access and refresh tokens for clients that are
    /// authenticated using
    /// client secrets. The access token can be used to fetch short-lived
    /// credentials for the assigned
    /// AWS accounts or to access application APIs using `bearer` authentication.
    pub fn createToken(self: *Self, allocator: std.mem.Allocator, input: create_token.CreateTokenInput, options: create_token.Options) !create_token.CreateTokenOutput {
        return create_token.execute(self, allocator, input, options);
    }

    /// Creates and returns access and refresh tokens for authorized client
    /// applications that are
    /// authenticated using any IAM entity, such as a service
    /// role or user. These tokens might contain defined scopes that specify
    /// permissions such as `read:profile` or `write:data`. Through downscoping, you
    /// can use the scopes parameter to request tokens with reduced permissions
    /// compared to the original client application's permissions or, if applicable,
    /// the refresh token's scopes. The access token can be used to fetch
    /// short-lived credentials for the assigned
    /// Amazon Web Services accounts or to access application APIs using `bearer`
    /// authentication.
    ///
    /// This API is used with Signature Version 4. For more information, see [Amazon
    /// Web Services Signature
    /// Version 4 for API
    /// Requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_sigv.html).
    pub fn createTokenWithIam(self: *Self, allocator: std.mem.Allocator, input: create_token_with_iam.CreateTokenWithIAMInput, options: create_token_with_iam.Options) !create_token_with_iam.CreateTokenWithIAMOutput {
        return create_token_with_iam.execute(self, allocator, input, options);
    }

    /// Registers a public client with IAM Identity Center. This allows clients
    /// to perform authorization using
    /// the authorization code grant with Proof Key for Code Exchange (PKCE)
    /// or the device
    /// code grant.
    pub fn registerClient(self: *Self, allocator: std.mem.Allocator, input: register_client.RegisterClientInput, options: register_client.Options) !register_client.RegisterClientOutput {
        return register_client.execute(self, allocator, input, options);
    }

    /// Initiates device authorization by requesting a pair of verification codes
    /// from the
    /// authorization service.
    pub fn startDeviceAuthorization(self: *Self, allocator: std.mem.Allocator, input: start_device_authorization.StartDeviceAuthorizationInput, options: start_device_authorization.Options) !start_device_authorization.StartDeviceAuthorizationOutput {
        return start_device_authorization.execute(self, allocator, input, options);
    }
};
