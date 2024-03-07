defmodule Randnews.Util.SiteSelectorTest do
  use ExUnit.Case

  alias Randnews.Util.SiteSelector

  describe "invoke/1" do
    test "selects passed sites when given :only option" do
      assert SiteSelector.invoke(only: "ua_nv") == ["ua_nv"]

      assert SiteSelector.invoke(only: "ua_nv,ua_pravda") |> Enum.sort() ==
               ["ua_nv", "ua_pravda"] |> Enum.sort()

      assert SiteSelector.invoke(only: "unknown") == []
    end

    test "ignores passed sites when given :skip option" do
      refute SiteSelector.invoke(skip: "ua_fun24tv")
             |> Enum.member?("ua_fun24tv")

      refute SiteSelector.invoke(skip: "ua_fun24tv,ua_nv")
             |> Enum.member?("ua_fun24tv")

      refute SiteSelector.invoke(skip: "ua_fun24tv,ua_nv")
             |> Enum.member?("ua_nv")
    end

    test "returns all sites when :only and :skip are not set" do
      assert length(SiteSelector.invoke(count: 5)) > 1
    end

    test "returns all sites when both :only and :skip are passed" do
      assert length(SiteSelector.invoke(only: "ua_nv", skip: "ua_fun24tv")) > 1
    end
  end
end
