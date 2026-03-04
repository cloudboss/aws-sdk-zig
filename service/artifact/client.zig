const aws = @import("aws");
const std = @import("std");

const get_account_settings = @import("get_account_settings.zig");
const get_report = @import("get_report.zig");
const get_report_metadata = @import("get_report_metadata.zig");
const get_term_for_report = @import("get_term_for_report.zig");
const list_customer_agreements = @import("list_customer_agreements.zig");
const list_report_versions = @import("list_report_versions.zig");
const list_reports = @import("list_reports.zig");
const put_account_settings = @import("put_account_settings.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Artifact";

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

    /// Get the account settings for Artifact.
    pub fn getAccountSettings(self: *Self, allocator: std.mem.Allocator, input: get_account_settings.GetAccountSettingsInput, options: CallOptions) !get_account_settings.GetAccountSettingsOutput {
        return get_account_settings.execute(self, allocator, input, options);
    }

    /// Get the content for a single report.
    pub fn getReport(self: *Self, allocator: std.mem.Allocator, input: get_report.GetReportInput, options: CallOptions) !get_report.GetReportOutput {
        return get_report.execute(self, allocator, input, options);
    }

    /// Get the metadata for a single report.
    pub fn getReportMetadata(self: *Self, allocator: std.mem.Allocator, input: get_report_metadata.GetReportMetadataInput, options: CallOptions) !get_report_metadata.GetReportMetadataOutput {
        return get_report_metadata.execute(self, allocator, input, options);
    }

    /// Get the Term content associated with a single report.
    pub fn getTermForReport(self: *Self, allocator: std.mem.Allocator, input: get_term_for_report.GetTermForReportInput, options: CallOptions) !get_term_for_report.GetTermForReportOutput {
        return get_term_for_report.execute(self, allocator, input, options);
    }

    /// List active customer-agreements applicable to calling identity.
    pub fn listCustomerAgreements(self: *Self, allocator: std.mem.Allocator, input: list_customer_agreements.ListCustomerAgreementsInput, options: CallOptions) !list_customer_agreements.ListCustomerAgreementsOutput {
        return list_customer_agreements.execute(self, allocator, input, options);
    }

    /// List available report versions for a given report.
    pub fn listReportVersions(self: *Self, allocator: std.mem.Allocator, input: list_report_versions.ListReportVersionsInput, options: CallOptions) !list_report_versions.ListReportVersionsOutput {
        return list_report_versions.execute(self, allocator, input, options);
    }

    /// List available reports.
    pub fn listReports(self: *Self, allocator: std.mem.Allocator, input: list_reports.ListReportsInput, options: CallOptions) !list_reports.ListReportsOutput {
        return list_reports.execute(self, allocator, input, options);
    }

    /// Put the account settings for Artifact.
    pub fn putAccountSettings(self: *Self, allocator: std.mem.Allocator, input: put_account_settings.PutAccountSettingsInput, options: CallOptions) !put_account_settings.PutAccountSettingsOutput {
        return put_account_settings.execute(self, allocator, input, options);
    }

    pub fn listCustomerAgreementsPaginator(self: *Self, params: list_customer_agreements.ListCustomerAgreementsInput) paginator.ListCustomerAgreementsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listReportVersionsPaginator(self: *Self, params: list_report_versions.ListReportVersionsInput) paginator.ListReportVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listReportsPaginator(self: *Self, params: list_reports.ListReportsInput) paginator.ListReportsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
