Facter.add("mpc_zone") do
  setcode do
    ip = Facter.value('ipaddress')
    case ip[/^\d+\.(\d+)\.\d+\.\d+$/, 1]
    when '101'
      'bie'
    when '102'
      'zrh'
    else
      'undef'
    end
  end
end