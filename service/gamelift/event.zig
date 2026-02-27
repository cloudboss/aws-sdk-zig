const EventCode = @import("event_code.zig").EventCode;

/// Log entry describing an event that involves Amazon GameLift Servers
/// resources (such as a fleet). In
/// addition to tracking activity, event codes and messages can provide
/// additional
/// information for troubleshooting and debugging problems.
pub const Event = struct {
    /// The number of times that this event occurred.
    count: ?i64,

    /// The type of event being logged.
    ///
    /// **Fleet state transition events:**
    ///
    /// * FLEET_CREATED -- A fleet resource was successfully created with a status
    ///   of
    /// `NEW`. Event messaging includes the fleet ID.
    ///
    /// * FLEET_STATE_DOWNLOADING -- Fleet status changed from `NEW` to
    /// `DOWNLOADING`. Amazon GameLift Servers is downloading the compressed build
    /// and
    /// running install scripts.
    ///
    /// * FLEET_STATE_VALIDATING -- Fleet status changed from `DOWNLOADING`
    /// to `VALIDATING`. Amazon GameLift Servers has successfully installed build
    /// and is now
    /// validating the build files.
    ///
    /// * FLEET_STATE_BUILDING -- Fleet status changed from `VALIDATING` to
    /// `BUILDING`. Amazon GameLift Servers has successfully verified the build
    /// files and
    /// is now launching a fleet instance.
    ///
    /// * FLEET_STATE_ACTIVATING -- Fleet status changed from `BUILDING` to
    /// `ACTIVATING`. Amazon GameLift Servers is launching a game server process on
    /// the
    /// fleet instance and is testing its connectivity with the Amazon GameLift
    /// Servers service.
    ///
    /// * FLEET_STATE_ACTIVE -- The fleet's status changed from `ACTIVATING`
    /// to `ACTIVE`. The fleet is now ready to host game sessions.
    ///
    /// * FLEET_STATE_ERROR -- The Fleet's status changed to `ERROR`.
    /// Describe the fleet event message for more details.
    ///
    /// **Fleet creation events (ordered by fleet creation
    /// activity):**
    ///
    /// * FLEET_BINARY_DOWNLOAD_FAILED -- The build failed to download to the fleet
    /// instance.
    ///
    /// * FLEET_CREATION_EXTRACTING_BUILD -- The game server build was successfully
    /// downloaded to an instance, and Amazon GameLift Serversis now extracting the
    /// build files from the
    /// uploaded build. Failure at this stage prevents a fleet from moving to ACTIVE
    /// status. Logs for this stage display a list of the files that are extracted
    /// and
    /// saved on the instance. Access the logs by using the URL in
    /// *PreSignedLogUrl*.
    ///
    /// * FLEET_CREATION_RUNNING_INSTALLER -- The game server build files were
    /// successfully extracted, and Amazon GameLift Servers is now running the
    /// build's install script
    /// (if one is included). Failure in this stage prevents a fleet from moving to
    /// ACTIVE status. Logs for this stage list the installation steps and whether
    /// or
    /// not the install completed successfully. Access the logs by using the URL in
    /// *PreSignedLogUrl*.
    ///
    /// * FLEET_CREATION_COMPLETED_INSTALLER -- The game server build files were
    /// successfully installed and validation of the installation will begin
    /// soon.
    ///
    /// * FLEET_CREATION_FAILED_INSTALLER -- The installed failed while attempting
    ///   to
    /// install the build files. This event indicates that the failure occurred
    /// before
    /// Amazon GameLift Servers could start validation.
    ///
    /// * FLEET_CREATION_VALIDATING_RUNTIME_CONFIG -- The build process was
    ///   successful,
    /// and the GameLift is now verifying that the game server launch paths, which
    /// are
    /// specified in the fleet's runtime configuration, exist. If any listed launch
    /// path
    /// exists, Amazon GameLift Servers tries to launch a game server process and
    /// waits for the process
    /// to report ready. Failures in this stage prevent a fleet from moving to
    /// `ACTIVE` status. Logs for this stage list the launch paths in the
    /// runtime configuration and indicate whether each is found. Access the logs by
    /// using the URL in *PreSignedLogUrl*.
    ///
    /// * FLEET_VALIDATION_LAUNCH_PATH_NOT_FOUND -- Validation of the runtime
    /// configuration failed because the executable specified in a launch path does
    /// not
    /// exist on the instance.
    ///
    /// * FLEET_VALIDATION_EXECUTABLE_RUNTIME_FAILURE -- Validation of the runtime
    /// configuration failed because the executable specified in a launch path
    /// failed to
    /// run on the fleet instance.
    ///
    /// * FLEET_VALIDATION_TIMED_OUT -- Validation of the fleet at the end of
    ///   creation
    /// timed out. Try fleet creation again.
    ///
    /// * FLEET_ACTIVATION_FAILED -- The fleet failed to successfully complete one
    ///   of
    /// the steps in the fleet activation process. This event code indicates that
    /// the
    /// game build was successfully downloaded to a fleet instance, built, and
    /// validated, but was not able to start a server process. For more information,
    /// see
    /// [Debug Fleet Creation
    /// Issues](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-creating-debug.html#fleets-creating-debug-creation).
    ///
    /// * FLEET_ACTIVATION_FAILED_NO_INSTANCES -- Fleet creation was not able to
    ///   obtain
    /// any instances based on the input fleet attributes. Try again at a different
    /// time
    /// or choose a different combination of fleet attributes such as fleet type,
    /// instance type, etc.
    ///
    /// * FLEET_INITIALIZATION_FAILED -- A generic exception occurred during fleet
    /// creation. Describe the fleet event message for more details.
    ///
    /// **VPC peering events:**
    ///
    /// * FLEET_VPC_PEERING_SUCCEEDED -- A VPC peering connection has been
    ///   established
    /// between the VPC for an Amazon GameLift Servers fleet and a VPC in your
    /// Amazon Web Services account.
    ///
    /// * FLEET_VPC_PEERING_FAILED -- A requested VPC peering connection has failed.
    /// Event details and status information provide additional detail. A common
    /// reason
    /// for peering failure is that the two VPCs have overlapping CIDR blocks of
    /// IPv4
    /// addresses. To resolve this, change the CIDR block for the VPC in your Amazon
    /// Web Services
    /// account. For more information on VPC peering failures, see
    /// [https://docs.aws.amazon.com/AmazonVPC/latest/PeeringGuide/invalid-peering-configurations.html](https://docs.aws.amazon.com/AmazonVPC/latest/PeeringGuide/invalid-peering-configurations.html)
    ///
    /// * FLEET_VPC_PEERING_DELETED -- A VPC peering connection has been
    ///   successfully
    /// deleted.
    ///
    /// **Spot instance events:**
    ///
    /// * INSTANCE_INTERRUPTED -- A spot instance was interrupted by EC2 with a
    /// two-minute notification.
    ///
    /// * INSTANCE_RECYCLED -- A spot instance was determined to have a high risk
    /// of interruption and is scheduled to be recycled once it has no active
    /// game sessions.
    ///
    /// **Server process events:**
    ///
    /// * SERVER_PROCESS_INVALID_PATH -- The game server executable or script could
    ///   not
    /// be found based on the Fleet runtime configuration. Check that the launch
    /// path is
    /// correct based on the operating system of the Fleet.
    ///
    /// * SERVER_PROCESS_SDK_INITIALIZATION_TIMEOUT -- The server process did not
    ///   call
    /// `InitSDK()` within the time expected (5 minutes). Check your game
    /// session log to see why `InitSDK()` was not called in time. This event
    /// is not emitted for managed container fleets and Anywhere fleets unless
    /// they're
    /// deployed with the Amazon GameLift Servers Agent.
    ///
    /// * SERVER_PROCESS_PROCESS_READY_TIMEOUT -- The server process did not call
    /// `ProcessReady()` within the time expected (5 minutes) after
    /// calling `InitSDK()`. Check your game session log to see why
    /// `ProcessReady()` was not called in time.
    ///
    /// * SERVER_PROCESS_CRASHED -- The server process exited without calling
    /// `ProcessEnding()`. Check your game session log to see why
    /// `ProcessEnding()` was not called.
    ///
    /// * SERVER_PROCESS_TERMINATED_UNHEALTHY -- The server process did not report a
    /// valid health check for too long and was therefore terminated by GameLift.
    /// Check
    /// your game session log to see if the thread became stuck processing a
    /// synchronous
    /// task for too long.
    ///
    /// * SERVER_PROCESS_FORCE_TERMINATED -- The server process did not exit cleanly
    /// within the time expected after `OnProcessTerminate()` was sent. Check
    /// your game session log to see why termination took longer than expected.
    ///
    /// * SERVER_PROCESS_PROCESS_EXIT_TIMEOUT -- The server process did not exit
    ///   cleanly
    /// within the time expected (30 seconds) after calling
    /// `ProcessEnding()`. Check your game session log to see why termination
    /// took longer than expected.
    ///
    /// **Game session events:**
    ///
    /// * GAME_SESSION_ACTIVATION_TIMEOUT -- GameSession failed to activate within
    ///   the
    /// expected time. Check your game session log to see why
    /// `ActivateGameSession()` took longer to complete than
    /// expected.
    ///
    /// **Other fleet events:**
    ///
    /// * FLEET_SCALING_EVENT -- A change was made to the fleet's capacity settings
    /// (desired instances, minimum/maximum scaling limits). Event messaging
    /// includes
    /// the new capacity settings.
    ///
    /// * FLEET_NEW_GAME_SESSION_PROTECTION_POLICY_UPDATED -- A change was made to
    ///   the
    /// fleet's game session protection policy setting. Event messaging includes
    /// both
    /// the old and new policy setting.
    ///
    /// * FLEET_DELETED -- A request to delete a fleet was initiated.
    ///
    /// * GENERIC_EVENT -- An unspecified event has occurred.
    event_code: ?EventCode,

    /// A unique identifier for a fleet event.
    event_id: ?[]const u8,

    /// Time stamp indicating when this event occurred. Format is a number expressed
    /// in Unix time as milliseconds (for example `"1469498468.057"`).
    event_time: ?i64,

    /// Additional information related to the event.
    message: ?[]const u8,

    /// Location of stored logs with additional detail that is related to the event.
    /// This is
    /// useful for debugging issues. The URL is valid for 15 minutes. You can also
    /// access fleet
    /// creation logs through the Amazon GameLift Servers console.
    pre_signed_log_url: ?[]const u8,

    /// A unique identifier for an event resource, such as a fleet ID.
    resource_id: ?[]const u8,

    pub const json_field_names = .{
        .count = "Count",
        .event_code = "EventCode",
        .event_id = "EventId",
        .event_time = "EventTime",
        .message = "Message",
        .pre_signed_log_url = "PreSignedLogUrl",
        .resource_id = "ResourceId",
    };
};
