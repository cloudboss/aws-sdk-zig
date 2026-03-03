const aws = @import("aws");
const std = @import("std");

const create_component = @import("create_component.zig");
const create_form = @import("create_form.zig");
const create_theme = @import("create_theme.zig");
const delete_component = @import("delete_component.zig");
const delete_form = @import("delete_form.zig");
const delete_theme = @import("delete_theme.zig");
const exchange_code_for_token = @import("exchange_code_for_token.zig");
const export_components = @import("export_components.zig");
const export_forms = @import("export_forms.zig");
const export_themes = @import("export_themes.zig");
const get_codegen_job = @import("get_codegen_job.zig");
const get_component = @import("get_component.zig");
const get_form = @import("get_form.zig");
const get_metadata = @import("get_metadata.zig");
const get_theme = @import("get_theme.zig");
const list_codegen_jobs = @import("list_codegen_jobs.zig");
const list_components = @import("list_components.zig");
const list_forms = @import("list_forms.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_themes = @import("list_themes.zig");
const put_metadata_flag = @import("put_metadata_flag.zig");
const refresh_token = @import("refresh_token.zig");
const start_codegen_job = @import("start_codegen_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_component = @import("update_component.zig");
const update_form = @import("update_form.zig");
const update_theme = @import("update_theme.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AmplifyUIBuilder";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a new component for an Amplify app.
    pub fn createComponent(self: *Self, allocator: std.mem.Allocator, input: create_component.CreateComponentInput, options: create_component.Options) !create_component.CreateComponentOutput {
        return create_component.execute(self, allocator, input, options);
    }

    /// Creates a new form for an Amplify app.
    pub fn createForm(self: *Self, allocator: std.mem.Allocator, input: create_form.CreateFormInput, options: create_form.Options) !create_form.CreateFormOutput {
        return create_form.execute(self, allocator, input, options);
    }

    /// Creates a theme to apply to the components in an Amplify app.
    pub fn createTheme(self: *Self, allocator: std.mem.Allocator, input: create_theme.CreateThemeInput, options: create_theme.Options) !create_theme.CreateThemeOutput {
        return create_theme.execute(self, allocator, input, options);
    }

    /// Deletes a component from an Amplify app.
    pub fn deleteComponent(self: *Self, allocator: std.mem.Allocator, input: delete_component.DeleteComponentInput, options: delete_component.Options) !delete_component.DeleteComponentOutput {
        return delete_component.execute(self, allocator, input, options);
    }

    /// Deletes a form from an Amplify app.
    pub fn deleteForm(self: *Self, allocator: std.mem.Allocator, input: delete_form.DeleteFormInput, options: delete_form.Options) !delete_form.DeleteFormOutput {
        return delete_form.execute(self, allocator, input, options);
    }

    /// Deletes a theme from an Amplify app.
    pub fn deleteTheme(self: *Self, allocator: std.mem.Allocator, input: delete_theme.DeleteThemeInput, options: delete_theme.Options) !delete_theme.DeleteThemeOutput {
        return delete_theme.execute(self, allocator, input, options);
    }

    /// This is for internal use.
    ///
    /// Amplify uses this action to exchange an access code for a token.
    pub fn exchangeCodeForToken(self: *Self, allocator: std.mem.Allocator, input: exchange_code_for_token.ExchangeCodeForTokenInput, options: exchange_code_for_token.Options) !exchange_code_for_token.ExchangeCodeForTokenOutput {
        return exchange_code_for_token.execute(self, allocator, input, options);
    }

    /// Exports component configurations to code that is ready to integrate into an
    /// Amplify app.
    pub fn exportComponents(self: *Self, allocator: std.mem.Allocator, input: export_components.ExportComponentsInput, options: export_components.Options) !export_components.ExportComponentsOutput {
        return export_components.execute(self, allocator, input, options);
    }

    /// Exports form configurations to code that is ready to integrate into an
    /// Amplify app.
    pub fn exportForms(self: *Self, allocator: std.mem.Allocator, input: export_forms.ExportFormsInput, options: export_forms.Options) !export_forms.ExportFormsOutput {
        return export_forms.execute(self, allocator, input, options);
    }

    /// Exports theme configurations to code that is ready to integrate into an
    /// Amplify app.
    pub fn exportThemes(self: *Self, allocator: std.mem.Allocator, input: export_themes.ExportThemesInput, options: export_themes.Options) !export_themes.ExportThemesOutput {
        return export_themes.execute(self, allocator, input, options);
    }

    /// Returns an existing code generation job.
    pub fn getCodegenJob(self: *Self, allocator: std.mem.Allocator, input: get_codegen_job.GetCodegenJobInput, options: get_codegen_job.Options) !get_codegen_job.GetCodegenJobOutput {
        return get_codegen_job.execute(self, allocator, input, options);
    }

    /// Returns an existing component for an Amplify app.
    pub fn getComponent(self: *Self, allocator: std.mem.Allocator, input: get_component.GetComponentInput, options: get_component.Options) !get_component.GetComponentOutput {
        return get_component.execute(self, allocator, input, options);
    }

    /// Returns an existing form for an Amplify app.
    pub fn getForm(self: *Self, allocator: std.mem.Allocator, input: get_form.GetFormInput, options: get_form.Options) !get_form.GetFormOutput {
        return get_form.execute(self, allocator, input, options);
    }

    /// Returns existing metadata for an Amplify app.
    pub fn getMetadata(self: *Self, allocator: std.mem.Allocator, input: get_metadata.GetMetadataInput, options: get_metadata.Options) !get_metadata.GetMetadataOutput {
        return get_metadata.execute(self, allocator, input, options);
    }

    /// Returns an existing theme for an Amplify app.
    pub fn getTheme(self: *Self, allocator: std.mem.Allocator, input: get_theme.GetThemeInput, options: get_theme.Options) !get_theme.GetThemeOutput {
        return get_theme.execute(self, allocator, input, options);
    }

    /// Retrieves a list of code generation jobs for a specified Amplify app and
    /// backend environment.
    pub fn listCodegenJobs(self: *Self, allocator: std.mem.Allocator, input: list_codegen_jobs.ListCodegenJobsInput, options: list_codegen_jobs.Options) !list_codegen_jobs.ListCodegenJobsOutput {
        return list_codegen_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of components for a specified Amplify app and backend
    /// environment.
    pub fn listComponents(self: *Self, allocator: std.mem.Allocator, input: list_components.ListComponentsInput, options: list_components.Options) !list_components.ListComponentsOutput {
        return list_components.execute(self, allocator, input, options);
    }

    /// Retrieves a list of forms for a specified Amplify app and backend
    /// environment.
    pub fn listForms(self: *Self, allocator: std.mem.Allocator, input: list_forms.ListFormsInput, options: list_forms.Options) !list_forms.ListFormsOutput {
        return list_forms.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for a specified Amazon Resource Name (ARN).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves a list of themes for a specified Amplify app and backend
    /// environment.
    pub fn listThemes(self: *Self, allocator: std.mem.Allocator, input: list_themes.ListThemesInput, options: list_themes.Options) !list_themes.ListThemesOutput {
        return list_themes.execute(self, allocator, input, options);
    }

    /// Stores the metadata information about a feature on a form.
    pub fn putMetadataFlag(self: *Self, allocator: std.mem.Allocator, input: put_metadata_flag.PutMetadataFlagInput, options: put_metadata_flag.Options) !put_metadata_flag.PutMetadataFlagOutput {
        return put_metadata_flag.execute(self, allocator, input, options);
    }

    /// This is for internal use.
    ///
    /// Amplify uses this action to refresh a previously issued access token that
    /// might have expired.
    pub fn refreshToken(self: *Self, allocator: std.mem.Allocator, input: refresh_token.RefreshTokenInput, options: refresh_token.Options) !refresh_token.RefreshTokenOutput {
        return refresh_token.execute(self, allocator, input, options);
    }

    /// Starts a code generation job for a specified Amplify app and backend
    /// environment.
    pub fn startCodegenJob(self: *Self, allocator: std.mem.Allocator, input: start_codegen_job.StartCodegenJobInput, options: start_codegen_job.Options) !start_codegen_job.StartCodegenJobOutput {
        return start_codegen_job.execute(self, allocator, input, options);
    }

    /// Tags the resource with a tag key and value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Untags a resource with a specified Amazon Resource Name (ARN).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing component.
    pub fn updateComponent(self: *Self, allocator: std.mem.Allocator, input: update_component.UpdateComponentInput, options: update_component.Options) !update_component.UpdateComponentOutput {
        return update_component.execute(self, allocator, input, options);
    }

    /// Updates an existing form.
    pub fn updateForm(self: *Self, allocator: std.mem.Allocator, input: update_form.UpdateFormInput, options: update_form.Options) !update_form.UpdateFormOutput {
        return update_form.execute(self, allocator, input, options);
    }

    /// Updates an existing theme.
    pub fn updateTheme(self: *Self, allocator: std.mem.Allocator, input: update_theme.UpdateThemeInput, options: update_theme.Options) !update_theme.UpdateThemeOutput {
        return update_theme.execute(self, allocator, input, options);
    }

    pub fn exportComponentsPaginator(self: *Self, params: export_components.ExportComponentsInput) paginator.ExportComponentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn exportFormsPaginator(self: *Self, params: export_forms.ExportFormsInput) paginator.ExportFormsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn exportThemesPaginator(self: *Self, params: export_themes.ExportThemesInput) paginator.ExportThemesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCodegenJobsPaginator(self: *Self, params: list_codegen_jobs.ListCodegenJobsInput) paginator.ListCodegenJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComponentsPaginator(self: *Self, params: list_components.ListComponentsInput) paginator.ListComponentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFormsPaginator(self: *Self, params: list_forms.ListFormsInput) paginator.ListFormsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listThemesPaginator(self: *Self, params: list_themes.ListThemesInput) paginator.ListThemesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
