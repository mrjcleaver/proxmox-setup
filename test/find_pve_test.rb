require 'test/unit'
require 'proxmox-setup/pve-findable'

class FindPVE < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_fail

    fail('Not implemented')
  end

  def test_find_pve_by_ip

  end

  def test_find_pve_by_vm

  end

  def test_find_pve_by_env
    ENV['PVE'] = 'http://10.0.1.1:8006'
    return find_pve.must_equal('10.0.1.1')
  end

end