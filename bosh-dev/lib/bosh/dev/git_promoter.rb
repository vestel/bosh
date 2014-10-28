require 'open3'
require 'bosh/dev'

module Bosh::Dev
  class GitPromoter
    def initialize(logger)
      @logger = logger
    end

    def promote(dev_branch, stable_branch)
      raise ArgumentError, 'dev_branch is required' if dev_branch.to_s.empty?
      raise ArgumentError, 'stable_branch is required' if stable_branch.to_s.empty?

      stdout, stderr, status = exec_cmd("git push origin #{dev_branch}:#{stable_branch}")
      raise "Failed to git push local #{dev_branch} to origin #{stable_branch}: stdout: '#{stdout}', stderr: '#{stderr}'" unless status.success?
    end

    private

    def exec_cmd(cmd)
      @logger.info("Executing: #{cmd}")
      Open3.capture3(cmd)
    end
  end
end
