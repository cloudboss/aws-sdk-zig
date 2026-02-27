const aws = @import("aws");
const std = @import("std");

const associate_fraudster = @import("associate_fraudster.zig");
const create_domain = @import("create_domain.zig");
const create_watchlist = @import("create_watchlist.zig");
const delete_domain = @import("delete_domain.zig");
const delete_fraudster = @import("delete_fraudster.zig");
const delete_speaker = @import("delete_speaker.zig");
const delete_watchlist = @import("delete_watchlist.zig");
const describe_domain = @import("describe_domain.zig");
const describe_fraudster = @import("describe_fraudster.zig");
const describe_fraudster_registration_job = @import("describe_fraudster_registration_job.zig");
const describe_speaker = @import("describe_speaker.zig");
const describe_speaker_enrollment_job = @import("describe_speaker_enrollment_job.zig");
const describe_watchlist = @import("describe_watchlist.zig");
const disassociate_fraudster = @import("disassociate_fraudster.zig");
const evaluate_session = @import("evaluate_session.zig");
const list_domains = @import("list_domains.zig");
const list_fraudster_registration_jobs = @import("list_fraudster_registration_jobs.zig");
const list_fraudsters = @import("list_fraudsters.zig");
const list_speaker_enrollment_jobs = @import("list_speaker_enrollment_jobs.zig");
const list_speakers = @import("list_speakers.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_watchlists = @import("list_watchlists.zig");
const opt_out_speaker = @import("opt_out_speaker.zig");
const start_fraudster_registration_job = @import("start_fraudster_registration_job.zig");
const start_speaker_enrollment_job = @import("start_speaker_enrollment_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_domain = @import("update_domain.zig");
const update_watchlist = @import("update_watchlist.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Voice ID";

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

    /// Associates the fraudsters with the watchlist specified in the same domain.
    pub fn associateFraudster(self: *Self, allocator: std.mem.Allocator, input: associate_fraudster.AssociateFraudsterInput, options: associate_fraudster.Options) !associate_fraudster.AssociateFraudsterOutput {
        return associate_fraudster.execute(self, allocator, input, options);
    }

    /// Creates a domain that contains all Amazon Connect Voice ID data, such as
    /// speakers, fraudsters,
    /// customer audio, and voiceprints. Every domain is created with a default
    /// watchlist that fraudsters can be a part of.
    pub fn createDomain(self: *Self, allocator: std.mem.Allocator, input: create_domain.CreateDomainInput, options: create_domain.Options) !create_domain.CreateDomainOutput {
        return create_domain.execute(self, allocator, input, options);
    }

    /// Creates a watchlist that fraudsters can be a part of.
    pub fn createWatchlist(self: *Self, allocator: std.mem.Allocator, input: create_watchlist.CreateWatchlistInput, options: create_watchlist.Options) !create_watchlist.CreateWatchlistOutput {
        return create_watchlist.execute(self, allocator, input, options);
    }

    /// Deletes the specified domain from Voice ID.
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: delete_domain.Options) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// Deletes the specified fraudster from Voice ID. This action disassociates the
    /// fraudster from any watchlists it is a part of.
    pub fn deleteFraudster(self: *Self, allocator: std.mem.Allocator, input: delete_fraudster.DeleteFraudsterInput, options: delete_fraudster.Options) !delete_fraudster.DeleteFraudsterOutput {
        return delete_fraudster.execute(self, allocator, input, options);
    }

    /// Deletes the specified speaker from Voice ID.
    pub fn deleteSpeaker(self: *Self, allocator: std.mem.Allocator, input: delete_speaker.DeleteSpeakerInput, options: delete_speaker.Options) !delete_speaker.DeleteSpeakerOutput {
        return delete_speaker.execute(self, allocator, input, options);
    }

    /// Deletes the specified watchlist from Voice ID. This API throws an exception
    /// when
    /// there are fraudsters in the watchlist that you are trying to delete. You
    /// must delete the
    /// fraudsters, and then delete the watchlist. Every domain has a default
    /// watchlist which cannot be deleted.
    pub fn deleteWatchlist(self: *Self, allocator: std.mem.Allocator, input: delete_watchlist.DeleteWatchlistInput, options: delete_watchlist.Options) !delete_watchlist.DeleteWatchlistOutput {
        return delete_watchlist.execute(self, allocator, input, options);
    }

    /// Describes the specified domain.
    pub fn describeDomain(self: *Self, allocator: std.mem.Allocator, input: describe_domain.DescribeDomainInput, options: describe_domain.Options) !describe_domain.DescribeDomainOutput {
        return describe_domain.execute(self, allocator, input, options);
    }

    /// Describes the specified fraudster.
    pub fn describeFraudster(self: *Self, allocator: std.mem.Allocator, input: describe_fraudster.DescribeFraudsterInput, options: describe_fraudster.Options) !describe_fraudster.DescribeFraudsterOutput {
        return describe_fraudster.execute(self, allocator, input, options);
    }

    /// Describes the specified fraudster registration job.
    pub fn describeFraudsterRegistrationJob(self: *Self, allocator: std.mem.Allocator, input: describe_fraudster_registration_job.DescribeFraudsterRegistrationJobInput, options: describe_fraudster_registration_job.Options) !describe_fraudster_registration_job.DescribeFraudsterRegistrationJobOutput {
        return describe_fraudster_registration_job.execute(self, allocator, input, options);
    }

    /// Describes the specified speaker.
    pub fn describeSpeaker(self: *Self, allocator: std.mem.Allocator, input: describe_speaker.DescribeSpeakerInput, options: describe_speaker.Options) !describe_speaker.DescribeSpeakerOutput {
        return describe_speaker.execute(self, allocator, input, options);
    }

    /// Describes the specified speaker enrollment job.
    pub fn describeSpeakerEnrollmentJob(self: *Self, allocator: std.mem.Allocator, input: describe_speaker_enrollment_job.DescribeSpeakerEnrollmentJobInput, options: describe_speaker_enrollment_job.Options) !describe_speaker_enrollment_job.DescribeSpeakerEnrollmentJobOutput {
        return describe_speaker_enrollment_job.execute(self, allocator, input, options);
    }

    /// Describes the specified watchlist.
    pub fn describeWatchlist(self: *Self, allocator: std.mem.Allocator, input: describe_watchlist.DescribeWatchlistInput, options: describe_watchlist.Options) !describe_watchlist.DescribeWatchlistOutput {
        return describe_watchlist.execute(self, allocator, input, options);
    }

    /// Disassociates the fraudsters from the watchlist specified. Voice ID always
    /// expects a
    /// fraudster to be a part of at least one watchlist. If
    /// you try to disassociate a fraudster from its only watchlist, a
    /// `ValidationException` is thrown.
    pub fn disassociateFraudster(self: *Self, allocator: std.mem.Allocator, input: disassociate_fraudster.DisassociateFraudsterInput, options: disassociate_fraudster.Options) !disassociate_fraudster.DisassociateFraudsterOutput {
        return disassociate_fraudster.execute(self, allocator, input, options);
    }

    /// Evaluates a specified session based on audio data accumulated during a
    /// streaming
    /// Amazon Connect Voice ID call.
    pub fn evaluateSession(self: *Self, allocator: std.mem.Allocator, input: evaluate_session.EvaluateSessionInput, options: evaluate_session.Options) !evaluate_session.EvaluateSessionOutput {
        return evaluate_session.execute(self, allocator, input, options);
    }

    /// Lists all the domains in the Amazon Web Services account.
    pub fn listDomains(self: *Self, allocator: std.mem.Allocator, input: list_domains.ListDomainsInput, options: list_domains.Options) !list_domains.ListDomainsOutput {
        return list_domains.execute(self, allocator, input, options);
    }

    /// Lists all the fraudster registration jobs in the domain with the given
    /// `JobStatus`. If `JobStatus` is not provided, this lists all
    /// fraudster registration jobs in the given domain.
    pub fn listFraudsterRegistrationJobs(self: *Self, allocator: std.mem.Allocator, input: list_fraudster_registration_jobs.ListFraudsterRegistrationJobsInput, options: list_fraudster_registration_jobs.Options) !list_fraudster_registration_jobs.ListFraudsterRegistrationJobsOutput {
        return list_fraudster_registration_jobs.execute(self, allocator, input, options);
    }

    /// Lists all fraudsters in a specified watchlist or domain.
    pub fn listFraudsters(self: *Self, allocator: std.mem.Allocator, input: list_fraudsters.ListFraudstersInput, options: list_fraudsters.Options) !list_fraudsters.ListFraudstersOutput {
        return list_fraudsters.execute(self, allocator, input, options);
    }

    /// Lists all the speaker enrollment jobs in the domain with the specified
    /// `JobStatus`. If `JobStatus` is not provided, this lists all
    /// jobs with all possible speaker enrollment job statuses.
    pub fn listSpeakerEnrollmentJobs(self: *Self, allocator: std.mem.Allocator, input: list_speaker_enrollment_jobs.ListSpeakerEnrollmentJobsInput, options: list_speaker_enrollment_jobs.Options) !list_speaker_enrollment_jobs.ListSpeakerEnrollmentJobsOutput {
        return list_speaker_enrollment_jobs.execute(self, allocator, input, options);
    }

    /// Lists all speakers in a specified domain.
    pub fn listSpeakers(self: *Self, allocator: std.mem.Allocator, input: list_speakers.ListSpeakersInput, options: list_speakers.Options) !list_speakers.ListSpeakersOutput {
        return list_speakers.execute(self, allocator, input, options);
    }

    /// Lists all tags associated with a specified Voice ID resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists all watchlists in a specified domain.
    pub fn listWatchlists(self: *Self, allocator: std.mem.Allocator, input: list_watchlists.ListWatchlistsInput, options: list_watchlists.Options) !list_watchlists.ListWatchlistsOutput {
        return list_watchlists.execute(self, allocator, input, options);
    }

    /// Opts out a speaker from Voice ID. A speaker can be opted out regardless of
    /// whether or
    /// not they already exist in Voice ID. If they don't yet exist, a new speaker
    /// is created
    /// in an opted out state. If they already exist, their existing status is
    /// overridden and
    /// they are opted out. Enrollment and evaluation authentication requests are
    /// rejected for
    /// opted out speakers, and opted out speakers have no voice embeddings stored
    /// in
    /// Voice ID.
    pub fn optOutSpeaker(self: *Self, allocator: std.mem.Allocator, input: opt_out_speaker.OptOutSpeakerInput, options: opt_out_speaker.Options) !opt_out_speaker.OptOutSpeakerOutput {
        return opt_out_speaker.execute(self, allocator, input, options);
    }

    /// Starts a new batch fraudster registration job using provided details.
    pub fn startFraudsterRegistrationJob(self: *Self, allocator: std.mem.Allocator, input: start_fraudster_registration_job.StartFraudsterRegistrationJobInput, options: start_fraudster_registration_job.Options) !start_fraudster_registration_job.StartFraudsterRegistrationJobOutput {
        return start_fraudster_registration_job.execute(self, allocator, input, options);
    }

    /// Starts a new batch speaker enrollment job using specified details.
    pub fn startSpeakerEnrollmentJob(self: *Self, allocator: std.mem.Allocator, input: start_speaker_enrollment_job.StartSpeakerEnrollmentJobInput, options: start_speaker_enrollment_job.Options) !start_speaker_enrollment_job.StartSpeakerEnrollmentJobOutput {
        return start_speaker_enrollment_job.execute(self, allocator, input, options);
    }

    /// Tags a Voice ID resource with the provided list of tags.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes specified tags from a specified Amazon Connect Voice ID resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified domain. This API has clobber behavior, and clears and
    /// replaces
    /// all attributes. If an optional field, such as 'Description' is not provided,
    /// it is
    /// removed from the domain.
    pub fn updateDomain(self: *Self, allocator: std.mem.Allocator, input: update_domain.UpdateDomainInput, options: update_domain.Options) !update_domain.UpdateDomainOutput {
        return update_domain.execute(self, allocator, input, options);
    }

    /// Updates the specified watchlist. Every domain has a default watchlist which
    /// cannot be updated.
    pub fn updateWatchlist(self: *Self, allocator: std.mem.Allocator, input: update_watchlist.UpdateWatchlistInput, options: update_watchlist.Options) !update_watchlist.UpdateWatchlistOutput {
        return update_watchlist.execute(self, allocator, input, options);
    }

    pub fn listDomainsPaginator(self: *Self, params: list_domains.ListDomainsInput) paginator.ListDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFraudsterRegistrationJobsPaginator(self: *Self, params: list_fraudster_registration_jobs.ListFraudsterRegistrationJobsInput) paginator.ListFraudsterRegistrationJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFraudstersPaginator(self: *Self, params: list_fraudsters.ListFraudstersInput) paginator.ListFraudstersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSpeakerEnrollmentJobsPaginator(self: *Self, params: list_speaker_enrollment_jobs.ListSpeakerEnrollmentJobsInput) paginator.ListSpeakerEnrollmentJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSpeakersPaginator(self: *Self, params: list_speakers.ListSpeakersInput) paginator.ListSpeakersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWatchlistsPaginator(self: *Self, params: list_watchlists.ListWatchlistsInput) paginator.ListWatchlistsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
