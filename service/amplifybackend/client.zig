const aws = @import("aws");
const std = @import("std");

const clone_backend = @import("clone_backend.zig");
const create_backend = @import("create_backend.zig");
const create_backend_api = @import("create_backend_api.zig");
const create_backend_auth = @import("create_backend_auth.zig");
const create_backend_config = @import("create_backend_config.zig");
const create_backend_storage = @import("create_backend_storage.zig");
const create_token = @import("create_token.zig");
const delete_backend = @import("delete_backend.zig");
const delete_backend_api = @import("delete_backend_api.zig");
const delete_backend_auth = @import("delete_backend_auth.zig");
const delete_backend_storage = @import("delete_backend_storage.zig");
const delete_token = @import("delete_token.zig");
const generate_backend_api_models = @import("generate_backend_api_models.zig");
const get_backend = @import("get_backend.zig");
const get_backend_api = @import("get_backend_api.zig");
const get_backend_api_models = @import("get_backend_api_models.zig");
const get_backend_auth = @import("get_backend_auth.zig");
const get_backend_job = @import("get_backend_job.zig");
const get_backend_storage = @import("get_backend_storage.zig");
const get_token = @import("get_token.zig");
const import_backend_auth = @import("import_backend_auth.zig");
const import_backend_storage = @import("import_backend_storage.zig");
const list_backend_jobs = @import("list_backend_jobs.zig");
const list_s3_buckets = @import("list_s3_buckets.zig");
const remove_all_backends = @import("remove_all_backends.zig");
const remove_backend_config = @import("remove_backend_config.zig");
const update_backend_api = @import("update_backend_api.zig");
const update_backend_auth = @import("update_backend_auth.zig");
const update_backend_config = @import("update_backend_config.zig");
const update_backend_job = @import("update_backend_job.zig");
const update_backend_storage = @import("update_backend_storage.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AmplifyBackend";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// This operation clones an existing backend.
    pub fn cloneBackend(self: *Self, allocator: std.mem.Allocator, input: clone_backend.CloneBackendInput, options: clone_backend.Options) !clone_backend.CloneBackendOutput {
        return clone_backend.execute(self, allocator, input, options);
    }

    /// This operation creates a backend for an Amplify app. Backends are
    /// automatically created at the time of app creation.
    pub fn createBackend(self: *Self, allocator: std.mem.Allocator, input: create_backend.CreateBackendInput, options: create_backend.Options) !create_backend.CreateBackendOutput {
        return create_backend.execute(self, allocator, input, options);
    }

    /// Creates a new backend API resource.
    pub fn createBackendApi(self: *Self, allocator: std.mem.Allocator, input: create_backend_api.CreateBackendAPIInput, options: create_backend_api.Options) !create_backend_api.CreateBackendAPIOutput {
        return create_backend_api.execute(self, allocator, input, options);
    }

    /// Creates a new backend authentication resource.
    pub fn createBackendAuth(self: *Self, allocator: std.mem.Allocator, input: create_backend_auth.CreateBackendAuthInput, options: create_backend_auth.Options) !create_backend_auth.CreateBackendAuthOutput {
        return create_backend_auth.execute(self, allocator, input, options);
    }

    /// Creates a config object for a backend.
    pub fn createBackendConfig(self: *Self, allocator: std.mem.Allocator, input: create_backend_config.CreateBackendConfigInput, options: create_backend_config.Options) !create_backend_config.CreateBackendConfigOutput {
        return create_backend_config.execute(self, allocator, input, options);
    }

    /// Creates a backend storage resource.
    pub fn createBackendStorage(self: *Self, allocator: std.mem.Allocator, input: create_backend_storage.CreateBackendStorageInput, options: create_backend_storage.Options) !create_backend_storage.CreateBackendStorageOutput {
        return create_backend_storage.execute(self, allocator, input, options);
    }

    /// Generates a one-time challenge code to authenticate a user into your Amplify
    /// Admin UI.
    pub fn createToken(self: *Self, allocator: std.mem.Allocator, input: create_token.CreateTokenInput, options: create_token.Options) !create_token.CreateTokenOutput {
        return create_token.execute(self, allocator, input, options);
    }

    /// Removes an existing environment from your Amplify project.
    pub fn deleteBackend(self: *Self, allocator: std.mem.Allocator, input: delete_backend.DeleteBackendInput, options: delete_backend.Options) !delete_backend.DeleteBackendOutput {
        return delete_backend.execute(self, allocator, input, options);
    }

    /// Deletes an existing backend API resource.
    pub fn deleteBackendApi(self: *Self, allocator: std.mem.Allocator, input: delete_backend_api.DeleteBackendAPIInput, options: delete_backend_api.Options) !delete_backend_api.DeleteBackendAPIOutput {
        return delete_backend_api.execute(self, allocator, input, options);
    }

    /// Deletes an existing backend authentication resource.
    pub fn deleteBackendAuth(self: *Self, allocator: std.mem.Allocator, input: delete_backend_auth.DeleteBackendAuthInput, options: delete_backend_auth.Options) !delete_backend_auth.DeleteBackendAuthOutput {
        return delete_backend_auth.execute(self, allocator, input, options);
    }

    /// Removes the specified backend storage resource.
    pub fn deleteBackendStorage(self: *Self, allocator: std.mem.Allocator, input: delete_backend_storage.DeleteBackendStorageInput, options: delete_backend_storage.Options) !delete_backend_storage.DeleteBackendStorageOutput {
        return delete_backend_storage.execute(self, allocator, input, options);
    }

    /// Deletes the challenge token based on the given appId and sessionId.
    pub fn deleteToken(self: *Self, allocator: std.mem.Allocator, input: delete_token.DeleteTokenInput, options: delete_token.Options) !delete_token.DeleteTokenOutput {
        return delete_token.execute(self, allocator, input, options);
    }

    /// Generates a model schema for an existing backend API resource.
    pub fn generateBackendApiModels(self: *Self, allocator: std.mem.Allocator, input: generate_backend_api_models.GenerateBackendAPIModelsInput, options: generate_backend_api_models.Options) !generate_backend_api_models.GenerateBackendAPIModelsOutput {
        return generate_backend_api_models.execute(self, allocator, input, options);
    }

    /// Provides project-level details for your Amplify UI project.
    pub fn getBackend(self: *Self, allocator: std.mem.Allocator, input: get_backend.GetBackendInput, options: get_backend.Options) !get_backend.GetBackendOutput {
        return get_backend.execute(self, allocator, input, options);
    }

    /// Gets the details for a backend API.
    pub fn getBackendApi(self: *Self, allocator: std.mem.Allocator, input: get_backend_api.GetBackendAPIInput, options: get_backend_api.Options) !get_backend_api.GetBackendAPIOutput {
        return get_backend_api.execute(self, allocator, input, options);
    }

    /// Gets a model introspection schema for an existing backend API resource.
    pub fn getBackendApiModels(self: *Self, allocator: std.mem.Allocator, input: get_backend_api_models.GetBackendAPIModelsInput, options: get_backend_api_models.Options) !get_backend_api_models.GetBackendAPIModelsOutput {
        return get_backend_api_models.execute(self, allocator, input, options);
    }

    /// Gets a backend auth details.
    pub fn getBackendAuth(self: *Self, allocator: std.mem.Allocator, input: get_backend_auth.GetBackendAuthInput, options: get_backend_auth.Options) !get_backend_auth.GetBackendAuthOutput {
        return get_backend_auth.execute(self, allocator, input, options);
    }

    /// Returns information about a specific job.
    pub fn getBackendJob(self: *Self, allocator: std.mem.Allocator, input: get_backend_job.GetBackendJobInput, options: get_backend_job.Options) !get_backend_job.GetBackendJobOutput {
        return get_backend_job.execute(self, allocator, input, options);
    }

    /// Gets details for a backend storage resource.
    pub fn getBackendStorage(self: *Self, allocator: std.mem.Allocator, input: get_backend_storage.GetBackendStorageInput, options: get_backend_storage.Options) !get_backend_storage.GetBackendStorageOutput {
        return get_backend_storage.execute(self, allocator, input, options);
    }

    /// Gets the challenge token based on the given appId and sessionId.
    pub fn getToken(self: *Self, allocator: std.mem.Allocator, input: get_token.GetTokenInput, options: get_token.Options) !get_token.GetTokenOutput {
        return get_token.execute(self, allocator, input, options);
    }

    /// Imports an existing backend authentication resource.
    pub fn importBackendAuth(self: *Self, allocator: std.mem.Allocator, input: import_backend_auth.ImportBackendAuthInput, options: import_backend_auth.Options) !import_backend_auth.ImportBackendAuthOutput {
        return import_backend_auth.execute(self, allocator, input, options);
    }

    /// Imports an existing backend storage resource.
    pub fn importBackendStorage(self: *Self, allocator: std.mem.Allocator, input: import_backend_storage.ImportBackendStorageInput, options: import_backend_storage.Options) !import_backend_storage.ImportBackendStorageOutput {
        return import_backend_storage.execute(self, allocator, input, options);
    }

    /// Lists the jobs for the backend of an Amplify app.
    pub fn listBackendJobs(self: *Self, allocator: std.mem.Allocator, input: list_backend_jobs.ListBackendJobsInput, options: list_backend_jobs.Options) !list_backend_jobs.ListBackendJobsOutput {
        return list_backend_jobs.execute(self, allocator, input, options);
    }

    /// The list of S3 buckets in your account.
    pub fn listS3Buckets(self: *Self, allocator: std.mem.Allocator, input: list_s3_buckets.ListS3BucketsInput, options: list_s3_buckets.Options) !list_s3_buckets.ListS3BucketsOutput {
        return list_s3_buckets.execute(self, allocator, input, options);
    }

    /// Removes all backend environments from your Amplify project.
    pub fn removeAllBackends(self: *Self, allocator: std.mem.Allocator, input: remove_all_backends.RemoveAllBackendsInput, options: remove_all_backends.Options) !remove_all_backends.RemoveAllBackendsOutput {
        return remove_all_backends.execute(self, allocator, input, options);
    }

    /// Removes the AWS resources required to access the Amplify Admin UI.
    pub fn removeBackendConfig(self: *Self, allocator: std.mem.Allocator, input: remove_backend_config.RemoveBackendConfigInput, options: remove_backend_config.Options) !remove_backend_config.RemoveBackendConfigOutput {
        return remove_backend_config.execute(self, allocator, input, options);
    }

    /// Updates an existing backend API resource.
    pub fn updateBackendApi(self: *Self, allocator: std.mem.Allocator, input: update_backend_api.UpdateBackendAPIInput, options: update_backend_api.Options) !update_backend_api.UpdateBackendAPIOutput {
        return update_backend_api.execute(self, allocator, input, options);
    }

    /// Updates an existing backend authentication resource.
    pub fn updateBackendAuth(self: *Self, allocator: std.mem.Allocator, input: update_backend_auth.UpdateBackendAuthInput, options: update_backend_auth.Options) !update_backend_auth.UpdateBackendAuthOutput {
        return update_backend_auth.execute(self, allocator, input, options);
    }

    /// Updates the AWS resources required to access the Amplify Admin UI.
    pub fn updateBackendConfig(self: *Self, allocator: std.mem.Allocator, input: update_backend_config.UpdateBackendConfigInput, options: update_backend_config.Options) !update_backend_config.UpdateBackendConfigOutput {
        return update_backend_config.execute(self, allocator, input, options);
    }

    /// Updates a specific job.
    pub fn updateBackendJob(self: *Self, allocator: std.mem.Allocator, input: update_backend_job.UpdateBackendJobInput, options: update_backend_job.Options) !update_backend_job.UpdateBackendJobOutput {
        return update_backend_job.execute(self, allocator, input, options);
    }

    /// Updates an existing backend storage resource.
    pub fn updateBackendStorage(self: *Self, allocator: std.mem.Allocator, input: update_backend_storage.UpdateBackendStorageInput, options: update_backend_storage.Options) !update_backend_storage.UpdateBackendStorageOutput {
        return update_backend_storage.execute(self, allocator, input, options);
    }
};
