clear 
close all 

T_A = 4e-3;
f_A = 1/T_A;
BUFFERSIZE = 7500;
t = linspace(0,30,BUFFERSIZE);
cut_off = 50/f_A/2;
order = 16;


EKG = [1265     1290    1317	1350	1392	1447	1621	1693	1729	1772	1807	1830	1857	1883	1904	1905	1911	1920	1929	1934	1933	1936	1945	1942	1940	1946	1939	1942	1943	1953	1947	1942	1938	1939	1939	1937	1935	1938	1939	1938	1942	1934	1936	1937	1939	1936	1936	1937	1936	1938	1936	1933	1935	1937	1936	1936	1938	1936	1935	1936	1935	1934	1939	1935	1936	1936	1934	1936	1936	1938	1935	1935	1936	1936	1937	1939	1936	1937	1938	1936	1935	1931	1929	1931	1933	1931	1934	1935	1931	1936	1936	1936	1936	1936	1936	1957	1968	1963	1957	1936	1921	1913	1904	1898	1902	1904	1910	1917	1917	1911	1910	1909	1914	1917	1914	1902	1905	1903	1901	1901	1876	1808	1695	1630	1746	2089	2621	3421	4095	4095	4095	4095	4095	3733	2633	2422	2224	1969	1811	1729	1665	1616	1583	1559	1551	1552	1552	1547	1549	1547	1534	1535	1547	1546	1550	1548	1549	1547	1535	1535	1530	1531	1531	1521	1514	1505	1505	1484	1479	1461	1447	1433	1415	1397	1376	1351	1331	1321	1307	1281	1268	1263	1266	1267	1275	1285	1310	1338	1380	1424	1478	1533	1586	1632	1680	1725	1765	1803	1833	1857	1872	1891	1904	1910	1914	1915	1925	1925	1926	1925	1932	1936	1936	1936	1936	1936	1939	1938	1936	1934	1931	1936	1936	1936	1935	1936	1940	1939	1936	1936	1937	1937	1933	1930	1931	1933	1935	1936	1937	1936	1934	1936	1936	1937	1935	1932	1929	1924	1925	1920	1923	1931	1931	1930	1929	1935	1931	1930	1933	1930	1930	1929	1936	1932	1921	1921	1925	1925	1919	1919	1919	1923	1923	1922	1923	1931	1936	1936	1934	1927	1925	1945	1965	1959	1946	1939	1936	1920	1909	1894	1891	1895	1905	1915	1910	1904	1898	1899	1921	1915	1914	1916	1911	1913	1907	1904	1904	1873	1810	1699	1631	1731	2031	2521	3270	4095	4095	4095	4095	4095	3583	2602	2425	2192	1945	1799	1725	1665	1625	1591	1577	1570	1569	1567	1555	1552	1555	1555	1555	1554	1555	1556	1552	1553	1555	1552	1547	1535	1535	1527	1525	1520	1511	1505	1487	1472	1458	1453	1430	1417	1398	1377	1358	1334	1313	1303	1295	1282	1277	1279	1277	1276	1295	1319	1349	1394	1435	1488	1533	1584	1638	1689	1732	1776	1808	1840	1870	1886	1898	1905	1921	1925	1936	1937	1934	1936	1945	1942	1939	1944	1940	1946	1949	1942	1937	1938	1939	1942	1937	1939	1941	1942	1941	1937	1936	1936	1935	1936	1936	1936	1935	1936	1936	1935	1946	1946	1936	1936	1941	1937	1936	1939	1946	1939	1938	1940	1945	1941	1937	1936	1941	1943	1939	1939	1936	1936	1939	1939	1934	1932	1936	1937	1936	1935	1929	1924	1927	1927	1923	1925	1927	1926	1929	1920	1917	1922	1927	1925	1927	1929	1935	1935	1929	1924	1939	1955	1954	1946	1936	1919	1913	1906	1899	1895	1902	1910	1915	1915	1909	1907	1911	1911	1909	1911	1911	1906	1906	1906	1904	1891	1870	1794	1698	1632	1726	2008	2494	3234	4095	4095	4095	4095	4095	3409	2559	2433	2255	1990	1813	1725	1679	1630	1597	1585	1581	1584	1590	1611	1622	1638	1648	1659	1685	1691	1675	1669	1623	1610	1601	1578	1599	1598	1535	1478	1518	1518	1471	1445	1488	1495	1488	1446	1415	1398	1379	1335	1344	1315	1257	1246	1283	1293	1282	1299	1303	1339	1364	1368	1382	1439	1488	1522	1589	1634	1665	1696	1732	1775	1795	1823	1836	1845	1859	1872	1872	1892	1889	1887	1881	1894	1905	1915	1921	1917	1914	1915	1927	1931	1923	1921	1926	1922	1938	1939	1936	1936	1935	1936	1950	1956	1948	1941	1943	1942	1946	1959	1966	1955	1945	1947	1953	1958	1953	1953	1956	1943	1937	1940	1941	1940	1939	1943	1941	1936	1933	1934	1938	1936	1934	1936	1937	1936	1931	1933	1938	1943	1955	1962	1951	1943	1942	1955	1956	1957	1965	1956	1950	1946	1936	1923	1918	1921	1930	1934	1929	1923	1931	1926	1925	1929	1930	1933	1925	1917	1920	1929	1936	1902	1837	1744	1673	1680	1853	2224	2880	3821	4095	4095	4095	4095	3664	2608	2391	2250	2025	1859	1781	1712	1668	1644	1622	1610	1597	1583	1585	1587	1586	1579	1581	1591	1600	1590	1584	1579	1584	1593	1584	1577	1584	1573	1552	1552	1535	1533	1535	1530	1521	1494	1467	1463	1444	1440	1424	1404	1391	1379	1362	1360	1373	1375	1374	1389	1406	1424	1441	1484	1535	1562	1606	1663	1698	1728	1769	1794	1815	1845	1869	1872	1883	1902	1911	1907	1906	1931	1926	1915	1911	1922	1927	1936	1936	1930	1919	1914	1913	1907	1913	1914	1917	1913	1910	1906	1907	1915	1919	1917	1917	1914	1904	1906	1907	1909	1909	1911	1917	1921	1915	1903	1904	1916	1921	1913	1920	1923	1911	1911	1917	1920	1919	1919	1914	1922	1923	1929	1926	1913	1919	1930	1927	1921	1911	1918	1923	1927	1922	1921	1925	1932	1935	1935	1923	1930	1941	1963	1968	1955	1955	1957	1941	1933	1930	1905	1900	1904	1907	1915	1919	1921	1919	1918	1915	1912	1913	1907	1904	1905	1904	1904	1903	1883	1826	1715	1641	1715	2000	2481	3157	4079	4095	4095	4095	4095	3207	2435	2316	2179	1968	1822	1743	1686	1648	1604	1591	1598	1584	1583	1581	1587	1585	1582	1570	1571	1579	1580	1584	1575	1578	1580	1581	1584	1577	1568	1561	1552	1551	1522	1524	1522	1507	1487	1471	1459	1441	1427	1413	1397	1390	1374	1361	1353	1352	1355	1360	1376	1394	1414	1441	1479	1525	1576	1617	1664	1713	1743	1779	1796	1821	1847	1869	1879	1890	1904	1914	1916	1917	1919	1917	1915	1922	1922	1923	1935	1937	1937	1930	1925	1920	1930	1930	1932	1937	1936	1933	1929	1929	1920	1915	1915	1920	1921	1918	1919	1920	1917	1915	1914	1915	1913	1914	1917	1916	1907	1910	1915	1918	1913	1916	1921	1917	1922	1920	1918	1916	1915	1919	1925	1931	1919	1918	1914	1919	1918	1919	1915	1909	1915	1909	1907	1905	1917	1918	1918	1917	1907	1909	1904	1910	1913	1907	1904	1905	1911	1909	1906	1904	1914	1920	1914	1907	1906	1904	1904	1893	1902	1902	1901	1907	1907	1915	1917	1915	1916	1917	1925	1941	1939	1937	1936	1913	1904	1899	1886	1875	1875	1883	1891	1893	1889	1893	1890	1900	1893	1894	1887	1883	1889	1886	1883	1875	1861	1806	1709	1677	1838	2229	2795	3632	4095	4095	4095	4095	4095	3566	2151	2160	2058	1847	1719	1661	1625	1590	1559	1523	1519	1520	1520	1523	1519	1517	1520	1525	1531	1531	1525	1526	1532	1529	1516	1519	1519	1523	1514	1501	1500	1490	1483	1473	1460	1450	1438	1421	1398	1379	1366	1354	1338	1318	1306	1296	1296	1296	1296	1296	1309	1333	1360	1393	1441	1489	1552	1590	1632	1680	1722	1754	1792	1823	1842	1857	1871	1879	1887	1891	1901	1911	1907	1907	1907	1909	1916	1920	1930	1926	1924	1926	1929	1931	1924	1930	1934	1932	1923	1917	1919	1923	1925	1923	1923	1923	1922	1920	1919	1917	1918	1911	1920	1914	1917	1922	1917	1911	1908	1905	1917	1921	1924	1919	1919	1917	1913	1919	1921	1917	1920	1920	1927	1926	1919	1920	1923	1934	1923	1922	1924	1921	1922	1925	1924	1923	1924	1918	1917	1918	1926	1924	1920	1914	1914	1919	1922	1924	1916	1918	1911	1910	1910	1905	1913	1919	1919	1916	1914	1911	1907	1910	1907	1906	1909	1919	1914	1909	1903	1904	1907	1907	1910	1905	1904	1910	1904	1904	1901	1901	1904	1903	1896	1893	1897	1903	1904	1900	1902	1899	1899	1901	1893	1898	1897	1907	1904	1903	1898	1899	1899	1901	1888	1889	1893	1893	1895	1900	1901	1893	1893	1889	1891	1887	1891	1885	1883	1886	1886	1887	1890	1901	1902	1893	1902	1904	1915	1915	1920	1909	1899	1890	1872	1858	1861	1870	1881	1883	1877	1877	1872	1873	1873	1872	1875	1874	1872	1871	1869	1871	1854	1799	1701	1667	1898	2357	2942	3890	4095	4095	4095	4095	4095	3579	2367	2112	2087	1901	1739	1679	1634	1591	1550	1520	1510	1515	1511	1507	1499	1507	1507	1505	1505	1515	1519	1516	1510	1513	1518	1514	1516	1507	1494	1488	1488	1488	1475	1459	1453	1446	1434	1415	1394	1377	1360	1350	1333	1314	1301	1285	1282	1276	1270	1274	1283	1302	1328	1358	1392	1440	1489	1545	1587	1635	1682	1723	1762	1796	1821	1840	1867	1872	1888	1898	1907	1915	1917	1925	1927	1926	1919	1924	1924	1927	1922	1934	1933	1927	1934	1930	1934	1930	1926	1927	1921	1923	1921	1926	1923	1923	1923	1921	1919	1921	1931	1929	1927	1925	1924	1927	1929	1924	1921	1919	1920	1923	1920	1923	1923	1921	1920	1916	1918	1929	1929	1925	1924	1923	1925	1927	1923	1918	1921	1921	1923	1923	1920	1915	1923	1930	1930	1923	1921	1923	1925	1919	1914	1918	1932	1922	1921	1920	1919	1917	1921	1919	1911	1915	1922	1917	1914	1915	1913	1919	1922	1917	1911	1919	1915	1914	1904	1903	1905	1914	1915	1907	1904	1904	1905	1906	1904	1904	1907	1909	1910	1909	1904	1905	1907	1907	1904	1904	1906	1909	1905	1898	1899	1914	1906	1903	1901	1894	1895	1896	1899	1902	1902	1901	1898	1904	1901	1894	1902	1901	1902	1904	1904	1910	1906	1899	1882	1872	1875	1875	1901	1901	1886	1872	1877	1881	1883	1884	1885	1890	1889	1885	1874	1888	1889	1889	1887	1882	1879	1885	1885	1884	1860	1798	1682	1681	1907	2351	2926	3852	4095	4095	4095	4095	4095	3437	2367	2198	2137	1926	1769	1698	1648	1610	1579	1552	1535	1523	1520	1525	1534	1527	1525	1521	1527	1526	1527	1525	1530	1529	1520	1520	1517	1509	1510	1507	1498	1490	1488	1473	1467	1455	1437	1424	1398	1382	1367	1353	1331	1319	1311	1295	1285	1281	1280	1276	1280	1296	1326	1355	1389	1426	1478	1531	1584	1631	1680	1723	1766	1791	1840	1861	1872	1890	1902	1904	1904	1915	1922	1929	1924	1917	1921	1927	1934	1934	1933	1933	1937	1938	1937	1936	1935	1937	1927	1927	1923	1935	1929	1933	1923	1923	1932	1929	1925	1922	1927	1929	1921	1921	1919	1923	1929	1931	1930	1924	1918	1921	1927	1923	1922	1927	1936	1933	1923	1923	1929	1930	1926	1923	1921	1925	1929	1927	1925	1921	1923	1927	1921	1919	1920	1925	1927	1925	1919	1918	1904	1921	1926	1921	1923	1923	1923	1923	1917	1922	1921	1923	1922	1909	1918	1919	1922	1918	1914	1915	1915	1915	1910	1898	1904	1904	1906	1905	1903	1904	1907	1905	1906	1909	1911	1905	1907	1904	1901	1904	1909	1913	1910	1904	1906	1904	1899	1898	1902	1897	1901	1906	1903	1902	1904	1899	1903	1899	1903	1895	1900	1899	1897	1891	1899	1899	1901	1904	1908	1911	1898	1886	1886	1875	1870	1885	1879	1872	1869	1871	1874	1882	1878	1882	1887	1891	1889	1888	1885	1893	1891	1891	1887	1881	1886	1891	1889	1862	1782	1681	1663	1987	2503	3133	4095	4095	4095	4095	4095	4095	2684	2285	2241	2037	1840	1727	1679	1637	1604	1578	1552	1546	1535	1526	1527	1521	1542	1535	1531	1530	1532	1531	1530	1525	1527	1525	1526	1520	1513	1514	1507	1499	1488	1480	1483	1469	1452	1429	1420	1406	1391	1364	1350	1334	1319	1309	1295	1286	1282	1283	1295	1302	1322	1345	1391	1424	1469	1517	1573	1621	1663	1702	1744	1779	1811	1831	1844	1872	1885	1902	1904	1908	1909	1919	1923	1931	1927	1929	1930	1931	1936	1933	1934	1937	1936	1936	1936	1933	1935	1931	1934	1927	1933	1936	1934	1936	1929	1927	1925	1933	1926	1922	1925	1933	1934	1925	1926	1927	1929	1934	1934	1927	1922	1926	1930	1935	1927	1924	1922	1928	1926	1927	1927	1921	1928	1933	1936	1935	1934	1933	1936	1934	1926	1930	1934	1935	1933	1936	1936	1936	1936	1922	1922	1924	1923	1925	1921	1918	1921	1921	1924	1920	1923	1921	1921	1917	1916	1919	1920	1922	1920	1912	1915	1920	1925	1921	1914	1907	1908	1918	1910	1907	1914	1918	1920	1917	1907	1914	1915	1912	1905	1903	1911	1918	1917	1906	1904	1904	1905	1907	1903	1901	1889	1902	1904	1894	1887	1883	1878	1878	1875	1891	1894	1897	1898	1899	1899	1891	1895	1898	1893	1897	1898	1898	1894	1885	1883	1845	1777	1658	1658	1807	2125	2655	3461	4095	4095	4095	4095	4095	3059	2414	2352	2175	1935	1788	1715	1670	1629	1594	1575	1566	1562	1560	1552	1552	1553	1551	1552	1551	1549	1560	1558	1552	1550	1546	1549	1546	1531	1525	1518	1518	1520	1511	1505	1491	1481	1463	1445	1426	1411	1395	1385	1365	1345	1328	1318	1310	1306	1306	1300	1309	1323	1339	1361	1402	1441	1485	1533	1587	1631	1681	1727	1763	1791	1825	1850	1866	1884	1892	1898	1904	1917	1929	1927	1924	1926	1930	1929	1930	1929	1935	1936	1937	1936	1936	1939	1943	1951	1939	1936	1936	1936	1934	1936	1935	1935	1936	1936	1937	1939	1939	1935	1931	1930	1932	1938	1936	1935	1931	1930	1929	1932	1936	1922	1922	1931	1921	1926	1933	1935	1935	1936	1935	1933	1936	1935	1931	1925	1923	1933	1936	1936	1934	1936	1935	1937	1943	1942	1940	1951	1935	1926	1933	1949	1967	1949	1931	1923	1942	1961	1957	1939	1919	1920	1921	1925	1927	1915	1904	1911	1919	1915	1902	1893	1890	1905	1906	1902	1895	1903	1904	1904	1904	1905	1904	1906	1917	1909	1913	1907	1904	1901	1897	1891	1900	1904	1902	1891	1883	1879	1874	1889	1899	1904	1905	1906	1903	1898	1905	1911	1902	1903	1904	1903	1905	1904	1904	1874	1808	1733	1691	1751	1965	2387	3066	3981	4095	4095	4095	3515	2594	2399	2282	2068	1883	1787	1725	1679	1639	1610	1599	1595	1591	1586	1584	1584	1586	1588	1586	1575	1567	1573	1582	1587	1584	1571	1564	1558	1567	1571	1569	1559	1554	1552	1535	1527	1510	1495	1492	1482	1468	1458	1438	1422	1402	1383	1373	1360	1376	1392	1405	1393	1391	1410	1444	1478	1505	1551	1607	1648	1670	1698	1729	1764	1805	1831	1838	1858	1874	1890	1899	1890	1907	1913	1913	1907	1906	1913	1922	1925	1904	1910	1918	1909	1908	1921	1923	1920	1917	1918	1922	1921	1907	1909	1923	1927	1908	1904	1904	1908	1914	1910	1905	1909	1907	1906	1904	1902	1907	1911	1914	1911	1918	1931	1925	1904	1901	1912	1915	1923	1920	1922	1913	1904	1908	1908	1907	1915	1925	1932	1920	1906	1909	1921	1922	1923	1924	1927	1923	1914	1904	1902	1904	1909	1909	1904	1897	1895	1904	1905	1904	1909	1913	1910	1909	1899	1884	1893	1902	1893	1872	1882	1892	1895	1904	1904	1894	1899	1902	1907	1904	1897	1879	1906	1906	1905	1902	1884	1840	1751	1665	1686	1897	2274	2874	3721	4095	4095	4095	4095	3535	2569	2361	2248	2047	1870	1776	1716	1693	1637	1611	1599	1602	1600	1593	1587	1588	1589	1590	1584	1581	1587	1586	1585	1584	1584	1587	1590	1584	1569	1570	1582	1568	1551	1531	1519	1520	1523	1517	1499	1482	1467	1446	1435	1424	1407	1396	1391	1386	1378	1375	1391	1399	1424	1439	1461	1488	1525	1576	1615	1663	1700	1734	1771	1786	1814	1841	1861	1872	1891	1894	1899	1908	1914	1919	1923	1921	1922	1929	1928	1906	1909	1921	1922	1921	1934	1936	1931	1933	1931	1924	1927	1927	1930	1920	1913	1919	1922	1918	1918	1914	1917	1918	1913	1915	1920	1921	1919	1919	1915	1914	1927	1925	1909	1916	1914	1917	1919	1922	1920	1926	1927	1923	1919	1921	1923	1929	1924	1919	1924	1925	1925	1929	1920	1909	1925	1917	1907	1915	1919	1922	1922	1917	1911	1919	1920	1920	1917	1913	1914	1911	1917	1914	1913	1909	1909	1901	1907	1915	1898	1901	1895	1895	1890	1899	1903	1909	1905	1904	1904	1909	1905	1904	1904	1902	1905	1905	1903	1904	1904	1899	1856	1765	1680	1727	2267	2957	3778	4095	4095	4095	4095	4095	2907	2287	2253	2128	1929	1787	1719	1675	1628	1599	1584	1579	1574	1571	1566	1567	1553	1569	1565	1570	1562	1555	1565	1561	1556	1551	1549	1552	1556	1554	1550	1547	1531	1520	1506	1497	1493	1487	1467	1451	1434	1410	1392	1369	1349	1354	1345	1338	1325	1323	1330	1341	1359	1373	1411	1451	1489	1533	1583	1627	1671	1712	1747	1779	1809	1837	1857	1871	1883	1891	1904	1911	1915	1911	1915	1920	1920	1926	1927	1925	1926	1919	1920	1927	1929	1931	1920	1920	1921	1932	1934	1925	1909	1909	1915	1927	1934	1931	1918	1914	1920	1923	1919	1911	1913	1920	1923	1918	1919	1917	1918	1917	1917	1917	1911	1914	1918	1918	1911	1915	1922	1922	1922	1917	1921	1925	1921	1922	1916	1919	1917	1915	1909	1904	1907	1915	1914	1912	1914	1922	1919	1906	1904	1894	1899	1906	1909	1907	1910	1907	1906	1907	1914	1905	1904	1904	1904	1906	1904	1906	1906	1904	1904	1898	1903	1900	1899	1898	1904	1893	1901	1903	1905	1895	1894	1898	1895	1893	1887	1881	1874	1869	1872	1873	1876	1882	1887	1892	1895	1889	1891	1886	1893	1887	1891	1891	1897	1899	1893	1873	1821	1722	1680	1799	2133	2625	3377	4095	4095	4095	4095	4095	3984	2580	2207	2194	2016	1825	1718	1671	1623	1572	1552	1547	1547	1535	1535	1535	1534	1530	1535	1542	1534	1530	1530	1530	1533	1535	1533	1535	1535	1524	1518	1505	1503	1490	1479	1474	1456	1444	1429	1410	1393	1375	1362	1350	1332	1312	1301	1296	1289	1289	1295	1309	1325	1345	1376	1417	1462	1511	1568	1616	1670	1707	1744	1780	1808	1831	1859	1878	1889	1902	1906	1910	1918	1925	1924	1925	1926	1929	1929	1925	1927	1936	1942	1936	1939	1935	1934	1941	1939	1936	1936	1935	1933	1936	1933	1931	1936	1936	1934	1934	1920	1923	1920	1920	1923	1920	1923	1920	1922	1915	1911	1923	1918	1922	1923	1918	1919	1920	1923	1927	1930	1929	1927	1929	1931	1931	1927	1927	1931	1921	1916	1918	1924	1929	1930	1919	1925	1923	1930	1930	1923	1913	1915	1926	1927	1922	1915	1920	1922	1922	1920	1917	1919	1920	1920	1916	1903	1911	1922	1920	1914	1914	1917	1915	1915	1919	1919	1924	1927	1923	1913	1910	1917	1915	1913	1908	1910	1910	1910	1915	1920	1919	1909	1911	1909	1899	1901	1904	1904	1903	1891	1886	1885	1891	1903	1904	1905	1907	1904	1904	1904	1904	1909	1907	1908	1909	1905	1903	1895	1883	1836	1744	1681	1761	2047	2480	3163	4095	4095	4095	4095	4095	4095	2714	2241	2229	2067	1860	1745	1687	1643	1606	1582	1558	1561	1559	1552	1552	1553	1550	1549	1552	1552	1552	1552	1552	1551	1547	1551	1551	1551	1549	1535	1527	1515	1507	1503	1490	1474	1470	1456	1438	1418	1403	1387	1366	1345	1337	1331	1322	1309	1299	1302	1308	1311	1323	1346	1386	1423	1459	1497	1553	1603	1648	1687	1739	1770	1803	1831	1852	1867	1877	1891	1904	1917	1911	1912	1919	1924	1932	1927	1927	1931	1930	1931	1931	1935	1936	1934	1922	1925	1931	1938	1933	1934	1931	1935	1936	1936	1935	1933	1937	1936	1936	1935	1934	1939	1936	1931	1933	1921	1923	1923	1922	1926	1927	1923	1926	1936	1929	1925	1925	1931	1925	1917	1919	1923	1925	1923	1929	1930	1925	1925	1924	1920	1923	1931	1931	1921	1913	1910	1920	1922	1925	1926	1923	1921	1921	1920	1915	1906	1909	1914	1910	1906	1911	1915	1906	1913	1915	1909	1904	1903	1904	1904	1906	1899	1901	1909	1907	1906	1907	1904	1902	1899	1904	1913	1910	1911	1904	1899	1895	1890	1898	1902	1900	1890	1875	1877	1883	1882	1899	1901	1904	1893	1895	1897	1901	1897	1903	1903	1903	1904	1899	1893	1899	1882	1826	1726	1680	1765	2027	2471	3187	4095	4095	4095	4095	4095	3393	2458	2297	2224	2000	1823	1744	1709	1659	1616	1585	1578	1575	1574	1570	1566	1562	1563	1581	1583	1584	1584	1566	1557	1561	1575	1577	1558	1554	1552	1552	1552	1551	1532	1508	1503	1495	1482	1468	1455	1441	1425	1417	1403	1386	1372	1359	1337	1337	1348	1345	1343	1355	1373	1397	1424	1460	1505	1553	1593	1630	1667	1723	1763	1787	1805	1831	1856	1872	1884	1899	1887	1895	1904	1913	1935	1931	1905	1904	1914	1918	1909	1921	1935	1931	1917	1911	1919	1915	1909	1910	1923	1929	1924	1909	1915	1920	1923	1925	1935	1932	1912	1907	1904	1913	1923	1930	1929	1923	1923	1915	1919	1920	1920	1927	1925	1936	1943	1935	1919	1922	1915	1920	1910	1915	1921	1915	1919	1927	1929	1920	1919	1922	1919	1922	1922	1918	1907	1915	1920	1928	1919	1919	1913	1913	1914	1918	1921	1920	1908	1922	1905	1904	1905	1913	1918	1921	1919	1901	1901	1907	1923	1917	1898	1904	1906	1906	1919	1915	1904	1907	1897	1882	1876	1887	1900	1897	1903	1900	1919	1910	1901	1904	1907	1909	1919	1915	1914	1903	1895	1899	1873	1819	1713	1683	1847	2169	2727	3537	4095	4095	4095	4095	3709	2605	2314	2247	2061	1865	1773	1728	1686	1648	1615	1603	1601	1597	1588	1571	1580	1590	1593	1584	1582	1584	1584	1575	1565	1569	1579	1584	1580	1568	1558	1570	1573	1552	1525	1529	1530	1515	1503	1490	1471	1453	1438	1421	1405	1397	1397	1386	1377	1379	1386	1389	1401	1408	1426	1461	1503	1543	1581	1623	1669	1711	1741	1771	1801	1829	1847	1872	1879	1885	1894	1904	1909	1904	1904	1904	1911	1920	1930	1926	1929	1925	1922	1921	1917	1920	1927	1923	1920	1926	1923	1920	1925	1936	1930	1927	1919	1921	1919	1919	1916	1919	1907	1910	1918	1917	1920	1913	1915	1921	1918	1918	1914	1914	1910	1907	1914	1919	1919	1914	1919	1929	1921	1915	1903	1910	1919	1927	1922	1917	1908	1910	1922	1919	1917	1919	1920	1920	1915	1910	1915	1921	1921	1915	1906	1910	1909	1910	1913	1904	1911	1915	1913	1905	1906	1911	1913	1913	1905	1907	1910	1910	1907	1902	1901	1904	1913	1913	1909	1904	1902	1908	1910	1898	1890	1888	1886	1888	1901	1899	1903	1904	1903	1899	1903	1908	1908	1906	1899	1893	1903	1904	1904	1903	1891	1853	1776	1681	1686	1937	2265	2913	3753	4095	4095	4095	4095	4095	2827	2256	1846	1726	1680	1646	1613	1589	1569	1559	1555	1552	1552	1552	1558	1562	1553	1552	1561	1557	1562	1562	1557	1554	1553	1554	1558	1552	1547	1546	1535	1523	1514	1507	1495	1476	1466	1450	1430	1410	1393	1382	1367	1358	1356	1353	1347	1344	1353	1364	1382	1408	1441	1486	1531	1584	1633	1670	1710	1746	1780	1808	1830	1849	1872	1886	1889	1883	1904	1911	1920	1919	1915	1921	1922	1923	1925	1925	1934	1930	1931	1932	1933	1934	1933	1931	1934	1926	1926	1931	1931	1922	1919	1927	1931	1926	1929	1923	1921	1924	1925	1919	1920	1921	1922	1921	1916	1915	1921	1924	1919	1911	1913	1919	1921	1920	1911	1921	1921	1919	1919	1911	1914	1919	1919	1920	1917	1916	1919	1921	1921	1919	1919	1919	1915	1918	1917	1914	1914	1919	1918	1904	1904	1924	1920	1915	1915	1918	1918	1906	1906	1910	1904	1905	1908	1904	1904	1906	1904	1904	1904	1905	1904	1904	1906	1905	1908	1900	1905	1904	1903	1904	1904	1903	1904	1904	1900	1903	1904	1897	1889	1889	1889	1901	1904	1904	1897	1897	1898	1898	1897	1894	1891	1887	1879	1877	1886	1891	1893	1891	1891	1897	1899	1895	1891	1894	1890	1890	1893	1894	1891	1891	1884	1836	1741	1678	1794	2151	2871	3614	4095	4095	4095	4095	4095	4095	2640	2207	2173	1991	1805	1713	1665	1615	1579	1553	1543	1533	1531	1531	1521	1520	1513	1520	1523	1520	1522	1520	1520	1520	1517	1514	1516	1518	1515	1501	1493	1489	1489	1479	1467	1455	1444	1429	1413	1392	1383	1362	1335	1312	1301	1292	1280	1271	1270	1265	1280	1294	1309	1331	1370	1408	1458	1509	1565	1612	1657	1698	1741	1767	1801	1829	1847	1856	1869	1875	1885	1899	1907	1904	1903	1905	1907	1907	1917	1919	1920	1918	1918	1918	1910	1914	1921	1924	1923	1917	1917	1919	1918	1908	1909	1920	1923	1923	1923	1935	1930	1926	1933	1930	1922	1925	1926	1920	1919	1925	1925	1921	1917	1920	1920	1921	1923	1921	1917	1911	1918	1925	1920	1915	1920	1930	1936	1925	1922	1919	1919	1922	1920	1919	1913	1911	1920	1919	1917	1918	1922	1918	1915	1911	1904	1917	1921	1920	1914	1915	1907	1907	1911	1910	1904	1907	1913	1911	1904	1904	1909	1910	1905	1907	1907	1909	1907	1904	1904	1901	1899	1904	1904	1904	1902	1904	1903	1902	1903	1903	1904	1904	1904	1901	1902	1899	1904	1898	1900	1904	1904	1902	1901	1903	1894	1887	1898	1901	1898	1899	1893	1893	1889	1887	1892	1895	1895	1887	1879	1872	1877	1884	1884	1895	1899	1902	1889	1890	1889	1899	1900	1885	1883	1888	1881	1854	1766	1676	1714	1939	2320	2919	3935	4095	4095	4095	4095	4095	3127	2340	2268	2128	1898	1759	1691	1649	1607	1575	1559	1543	1535	1527	1520	1531	1534	1527	1527	1529	1530	1525	1529	1520	1520	1520	1522	1520	1515	1510	1509	1504	1492	1492	1477	1468	1457	1446	1424	1411	1403	1381	1360	1338	1322	1309	1299	1285	1277	1278	1281	1287	1301	1322	1345	1379	1423	1470	1511	1575	1625	1674	1712	1750	1785	1814	1840	1856	1870	1883	1902	1911	1919	1917	1919	1923	1920	1921	1925	1935	1939	1934	1936	1935	1936	1939	1938	1940	1938	1939	1943	1939	1936	1934	1935	1936	1937	1934	1933	1935	1941	1941	1938	1936	1933	1936	1936	1934	1927	1921	1923	1929	1936	1933	1925	1925	1929	1930	1930	1923	1925	1933	1933	1930	1931	1931	1927	1929	1933	1930	1932	1932	1931	1926	1920	1923	1920	1922	1921	1927	1930	1929	1929	1927	1922	1926	1926	1929	1923	1923	1927	1924	1919	1917	1919	1922	1928	1920	1917	1907	1908	1907	1915	1904	1906	1910	1906	1909	1904	1907	1904	1904	1899	1901	1897	1904	1909	1909	1904	1899	1899	1895	1895	1895	1893	1888	1893	1883	1877	1882	1888	1894	1898	1893	1901	1903	1903	1904	1902	1900	1904	1904	1902	1901	1901	1891	1856	1765	1671	1705	1935	2289	2961	3907	4095	4095	4095	4095	4095	3119	2390	2310	2128	1897	1770	1700	1661	1614	1583	1566	1552	1550	1546	1535	1546	1535	1529	1524	1531	1534	1535	1535	1527	1527	1535	1530	1530	1520	1518	1515	1510	1503	1490	1482	1474	1460	1445	1424	1408	1392	1377	1351	1344	1326	1310	1300	1296	1284	1277	1285	1296	1306	1324	1356	1389	1437	1486	1529	1584	1635	1685	1725	1761	1795	1827	1849	1867	1874	1901	1901	1907	1915	1924	1919	1923	1930	1935	1935	1930	1935	1939	1937	1938	1937	1937	1941	1938	1936	1933	1936	1936	1936	1931	1928	1934	1936	1937	1936	1935	1936	1936	1936	1935	1926	1927	1937	1937	1936	1936	1936	1931	1926	1925	1927	1935	1936	1936	1937	1934	1938	1936	1939	1937	1936	1936	1938	1942	1935	1933	1936	1942	1942	1934	1933	1935	1936	1940	1936	1927	1923	1925	1929	1936	1921	1932	1922	1933	1936	1939	1939	1939	1937	1932	1925	1936	1942	1958	1966	1965	1965	1973	1981	1968	1964	1981	1983	1989	1963	1919	1897	1920	1919	1923	1950	1947	1916	1904	1904	1927	1952	1923	1886	1863	1882	1909	1898	1865	1831	1778	1680	1669	1840	2186	2826	3898	4095	4095	4095	4095	4051	2681	2281	2206	2005	1815	1728	1679	1621	1594	1577	1554	1543	1535	1551	1545	1531	1523	1532	1535	1531	1532	1526	1545	1546	1547	1535	1530	1524	1527	1520	1521	1527	1515	1502	1499	1492	1471	1463	1462	1450	1427	1415	1402	1389	1376	1372	1367	1356	1348	1351	1355	1361	1369	1389	1419	1451	1473	1499	1530	1583	1632	1674	1703	1750	1777	1800	1819	1840	1863	1879	1873	1882	1890	1895	1898	1904	1902	1904	1907	1907	1910	1911	1906	1920	1921	1925	1919	1918	1922	1903	1904	1907	1910	1906	1905	1917	1914	1904	1917	1920	1922	1913	1906	1915	1920	1910	1917	1917	1929	1937	1927	1920	1907	1904	1918	1924	1922	1918	1909	1918	1918	1911	1915	1936	1934	1920	1919	1920	1931	1924	1919	1909	1907	1918	1931	1941	1945	1926	1915	1921	1937	1946	1943	1957	1955	1937	1911	1888	1889	1897	1910	1918	1923	1915	1906	1915	1904	1898	1905	1907	1906	1904	1902	1909	1904	1894	1863	1808	1738	1674	1728	1970	2448	3170	4095	4095	4095	4095	4095	3225	2451	2322	2175	1965	1829	1765	1716	1672	1639	1621	1603	1587	1587	1598	1601	1610	1611	1593	1581	1586	1582	1575	1584	1584	1598	1600	1589	1584	1572	1567	1568	1559	1552	1543	1531	1525	1520	1495	1475	1463	1455	1435	1424	1408	1401	1392	1382	1381	1387	1386	1387	1405	1437	1456	1478	1520	1559	1606	1648	1682	1719	1758	1792	1821	1839	1857	1872	1879	1893	1873	1887	1897	1911	1919	1918	1907	1911	1920	1923	1918	1918	1927	1933	1931	1921	1914	1915	1917	1920	1931	1929	1925	1924	1924	1915	1904	1905	1919	1921	1926	1932	1927	1924	1926	1911	1915	1919	1920	1926	1925	1919	1919	1923	1927	1919	1924	1927	1919	1919	1923	1911	1926	1927	1931	1922	1917	1919	1922	1926	1926	1924	1920	1921	1911	1914	1922	1922	1930	1936	1937	1923	1923	1936	1952	1954	1952	1939	1925	1920	1906	1899	1901	1903	1904	1904	1904	1904	1905	1904	1909	1906	1904	1914	1917	1913	1907	1903	1903	1903	1865	1786	1677	1735	2030	2512	3229	4095	4095	4095	4095	4095	3410	2463	2303	2212	2000	1835	1748	1697	1660	1617	1593	1584	1583	1585	1581	1562	1565	1569	1569	1565	1566	1570	1569	1568	1563	1566	1571	1565	1567	1562	1559	1545	1535	1527	1523	1513	1507	1499	1479	1466	1454	1449	1429	1414	1394	1387	1374	1363	1360	1359	1360	1365	1377	1393	1423	1452	1485	1524	1575	1616	1665	1711	1746	1785	1811	1838	1851	1872	1901	1906	1914	1915	1906	1909	1911	1919	1926	1931	1936	1931	1920	1931	1935	1936	1931	1936	1936	1936	1931	1931	1927	1929	1924	1936	1931	1931	1929	1935	1935	1925	1925	1935	1930	1935	1926	1923	1929	1930	1923	1921	1925	1934	1927	1931	1926	1922	1920	1913	1911	1915	1920	1931	1927	1922	1923	1922	1924	1920	1918	1922	1921	1931	1936	1923	1920	1923	1923	1927	1922	1917	1919	1919	1919	1907	1919	1911	1914	1915	1914	1911	1906	1906	1905	1904	1909	1915	1923	1933	1927	1917	1923	1938	1947	1939	1936	1927	1915	1911	1897	1876	1872	1875	1881	1888	1885	1889	1888	1885	1881	1885	1886	1883	1887	1885	1874	1879	1883	1867	1808	1712	1654	1769	2112	2624	3391	4095	4095	4095	4095	4095	3760	2470	2195	2160	1961	1786	1701	1660	1615	1579	1554	1534	1532	1529	1525	1533	1523	1520	1521	1515	1520	1527	1526	1522	1530	1529	1520	1520	1528	1520	1511	1510	1501	1488	1483	1475	1460	1450	1430	1419	1403	1380	1365	1347	1331	1314	1306	1295	1285	1294	1301	1313	1324	1341	1371	1413	1460	1505	1557	1610	1658	1703	1743	1771	1806	1835	1858	1872	1888	1904	1904	1910	1919	1922	1923	1926	1927	1927	1927	1931	1947	1952	1942	1935	1933	1936	1937	1930	1931	1930	1930	1931	1932	1931	1936	1929	1929	1935	1931	1934	1933	1926	1934	1933	1927	1933	1926	1931	1927	1925	1923	1927	1927	1923	1920	1923	1924	1920	1914	1919	1919	1918	1917	1921	1918	1918	1921	1927	1923	1920	1919	1918	1909	1909	1910	1909	1908	1909	1909	1911	1914	1917	1909	1904	1905	1904	1904	1913	1907	1910	1911	1915	1915	1917	1917	1915	1914	1915	1909	1904	1904	1904	1904	1905	1907	1905	1905	1910	1905	1904	1906	1903	1889	1887	1899	1904	1905	1904	1899	1895	1895	1903	1901	1897	1901	1911	1923	1917	1904	1915	1928	1939	1936	1930	1920	1907	1899	1883	1871	1885	1879	1894	1890	1876	1883	1883	1885	1882	1882	1885	1886	1882	1886	1886	1881	1859	1793	1687	1675	1865	2288	2854	3775	4095	4095	4095	4095	4095	4095	2605	2177	2135	1947	1767	1683	1636	1593	1552	1519	1508	1514	1509	1503	1497	1501	1510	1509	1507	1503	1506	1509	1497	1498	1501	1501	1494	1488	1486	1477	1477	1473	1464	1456	1453	1430	1414	1403	1389	1373	1359	1344	1323	1309	1291	1280	1270	1264	1264	1269	1290	1302	1322	1349	1391	1442	1495	1549	1593	1643	1689	1731	1771	1801	1823	1841	1872	1874	1884	1899	1894	1919	1915	1910	1910	1919	1926	1919	1915	1919	1926	1933	1927	1926	1929	1936	1935	1926	1924	1930	1936	1937	1936	1930	1932	1927	1926	1926	1927	1922	1924	1926	1926	1925	1930	1937	1930	1921	1923	1930	1933	1927	1923	1920	1923	1926	1925	1921	1921	1929	1933	1927	1929	1924	1921	1926	1922	1921	1919	1925	1934	1923	1919	1917	1921	1920	1922	1915	1914	1920	1922	1923	1917	1915	1921	1917	1913	1911	1920	1923	1917	1911	1909	1913	1919	1914	1915	1907	1908	1914	1915	1918	1915	1912	1918	1914	1906	1905	1907	1917	1919	1915	1903	1904	1906	1905	1904	1904	1905	1905	1905	1904	1895	1895	1903	1905	1904	1901	1896	1901	1899	1904	1901	1899	1907	1912	1904	1895	1905	1935	1936	1931	1911	1899	1899	1882	1872	1870	1882	1885	1891	1891	1888	1893	1898	1897	1887	1885	1883	1883	1882	1878	1877	1862	1808	1700	1664	1815	2220	2771	3651	4095	4095	4095	4095	4095	4095	2729	2205	2147	1961	1781	1692	1646	1600	1561	1534	1511	1503	1506	1506	1502	1499	1500	1500	1497	1498	1494	1500	1494	1491	1490	1488	1488	1489	1485	1478	1471	1470	1471	1465	1456	1437	1425	1415	1403	1383	1363	1355	1341	1328	1297	1282	1270	1265	1265	1264	1264	1279	1296	1322	1355	1397	1444	1493	1543	1595	1646	1696	1727	1761	1811	1830	1850	1865	1874	1891	1901	1913	1918	1919	1918	1917	1921	1919	1930	1932	1926	1934	1936	1934	1931	1933	1933	1925	1923	1931	1935	1936	1935	1930	1923	1925	1926	1928	1936	1934	1935	1936	1931	1929	1923	1926	1929	1936	1933	1931	1920	1924	1927	1930	1920	1915	1918	1911	1919	1923	1921	1919	1926	1921	1915	1916	1917	1913	1920	1920	1918	1918	1913	1919	1914	1916	1920	1915	1916	1911	1921	1931	1934	1934	1927	1923	1921	1914	1919	1921	1914	1922	1916	1911	1914	1911	1911	1910	1911	1915	1911	1909	1921	1917	1909	1909	1910	1917	1909	1905	1909	1919	1913	1907	1904	1906	1913	1905	1905	1902	1904	1907	1906	1909	1903	1904	1904	1911	1915	1913	1908	1906	1910	1919	1931	1935	1931	1927	1913	1902	1887	1876	1876	1883	1889	1894	1891	1887	1888	1887	1891	1894	1901	1903	1898	1882	1887	1893	1883	1835	1743	1658	1711	1983	2422	3119	4095	4095	4095	4095	4095	4095	2993	2350	2255	2067	1856	1739	1679	1629	1584	1552	1529	1531	1525	1522	1520	1520	1521	1520	1521	1527	1527	1520	1517	1519	1525	1523	1518	1507	1514	1515	1506	1501	1488	1477	1475	1466	1458	1435	1427	1415	1395	1379	1360	1344	1329	1315	1306	1299	1286	1279	1280	1293	1303	1322	1349	1383	1427	1470	1520	1577	1616	1671	1710	1755	1790	1829	1844	1865	1879	1895	1904	1904	1911	1916	1925	1926	1924	1929	1930	1934	1935	1934	1931	1933	1933	1930	1923	1914	1920	1926	1931	1925	1926	1927	1926	1920	1916	1918	1921	1920	1917	1920	1915	1915	1923	1923	1920	1918	1923	1920	1919	1918	1918	1929	1930	1923	1927	1930	1926	1927	1935	1935	1925	1927	1926	1921	1919	1930	1934	1928	1929	1929	1929	1927	1936	1931	1917	1915	1931	1921	1920	1925	1918	1920	1921	1925	1925	1925	1933	1930	1923	1921	1913	1918	1924	1921	1917	1909	1915	1920	1915	1909	1904	1915	1911	1915	1917	1915	1915	1909	1910	1905	1909	1913	1919	1923	1911	1907	1918	1937	1947	1937	1936	1929	1910	1905	1907	1885	1882	1895	1904	1898	1901	1902	1904	1904	1902	1904	1909	1910	1904	1893	1893	1901	1891	1843	1755	1668	1674	1846	2187	2801	3760	4095	4095	4095	4095	3734	2635	2400	2255	2010	1840	1750	1691	1648	1614	1581	1573	1570	1559	1563	1559	1556	1562	1571	1572	1570	1557	1553	1557	1556	1558	1561	1557	1562	1552	1545	1534	1531	1527	1521	1517	1505	1494	1485	1463	1452	1443	1422	1403	1386	1374	1363	1347	1329	1328	1328	1329	1339	1359	1377	1404	1438	1473	1517	1562	1607	1659	1703	1742	1776	1811	1839	1859	1878	1890	1899	1905	1913	1920	1921	1925	1936	1936	1931	1929	1935	1934	1937	1938	1939	1942	1947	1940	1936	1933	1935	1936	1936	1936	1935	1936	1936	1935	1927	1934	1930	1933	1932	1935	1933	1931	1935	1945	1943	1929	1925	1929	1933	1933	1923	1930	1937	1939	1939	1936	1934	1933	1931	1921	1921	1928	1934	1934	1929	1934	1933	1926	1927	1931	1925	1919	1919	1926	1927	1924	1926	1927	1925	1923	1920	1920	1924	1926	1916	1907	1917	1918	1917	1913	1905	1912	1911	1915	1916	1917	1918	1920	1915	1914	1915	1939	1947	1943	1936	1918	1914	1911	1904	1891	1894	1893	1906	1908	1904	1903	1903	1904	1901	1901	1897	1898	1899	1904	1897	1893	1873	1829	1743	1667	1700	1892	2275	2928	3920	4095	4095	4095	4095	3529	2557	2384	2254	2009	1831	1747	1687	1648	1613	1591	1584	1584	1591	1584	1580	1559	1555	1566	1567	1573	1581	1584	1580	1552	1559	1573	1574	1574	1571	1553	1547	1546	1544	1534	1525	1520	1517	1499	1482	1465	1446	1429	1424	1415	1394	1389	1371	1355	1357	1365	1363	1369	1387	1410	1428	1461	1503	1553	1590	1627	1671	1713	1740	1761	1805	1827	1840	1858	1885	1891	1889	1897	1895	1904	1914	1910	1919	1926	1927	1919	1930	1932	1923	1918	1915	1915	1923	1926	1923	1929	1905	1904	1908	1915	1914	1922	1935	1930	1920	1915	1917	1923	1910	1905	1917	1918	1921	1921	1930	1929	1919	1918	1922	1918	1911	1919	1929	1930	1925	1931	1923	1922	1923	1909	1916	1938	1941	1942	1933	1911	1913	1920	1922	1927	1931	1936	1936	1921	1916	1907	1918	1917	1914	1926	1929	1920	1924	1929	1936	1946	1941	1940	1939	1931	1927	1920	1908	1903	1904	1899	1897	1906	1923	1931	1906	1904	1915	1910	1904	1903	1914	1917	1908	1907	1874	1843	1762	1666	1680	1879	2253	2873	3771	4095	4095	4095	4095	3632	2601	2367	2237	2036	1875	1780	1723	1677	1635	1602	1602	1600	1584	1586	1587	1585	1584	1591	1594	1587	1586	1587	1585	1595	1594	1585	1584	1587	1582	1573	1571	1567	1563	1553	1549	1531	1520	1504	1498	1492	1475	1454	1437	1424	1419	1408	1392	1385	1387	1391	1397	1401	1408	1431	1467	1499	1530	1569	1616	1663	1700	1743	1774	1786	1831	1854	1873	1883	1886	1897	1899	1904	1921	1925	1923	1923	1919	1921	1927	1936	1939	1936	1936	1939	1936	1935	1933	1932	1923	1930	1935	1925	1936	1936	1930	1922	1923	1917	1918	1924	1925	1918	1919	1922	1921	1915	1920	1919	1917	1910	1909	1916	1921	1926	1930	1915	1911	1920	1922	1921	1922	1923	1922	1926	1929	1923	1920	1921	1921	1925	1921	1917	1916	1921	1922	1917	1911	1925	1933	1919	1921	1923	1913	1921	1934	1943	1947	1938	1927	1913	1904	1906	1899	1887	1898	1893	1900	1902	1906	1904	1903	1902	1904	1904	1897	1899	1895	1900	1904	1906	1887	1838	1745	1664	1712	1982	2439	3146	4095	4095	4095	4095	4095	3606	2510	2287	2224	2027	1846	1751	1690	1633	1601	1585	1576	1576	1584	1578	1573	1569	1569	1570	1580	1580	1571	1570	1571	1567	1574	1571	1566	1561	1559	1552	1546	1520	1523	1523	1520	1505	1492	1477	1458	1443	1426	1409	1395	1386	1367	1354	1353	1353	1357	1357	1360	1377	1407	1434	1467	1515	1558	1600	1669	1706	1739	1770	1795	1821	1846	1869	1881	1889	1893	1902	1904	1907	1919	1921	1921	1920	1917	1921	1923	1925	1920	1921	1929	1936	1934	1929	1930	1935	1932	1926	1922	1920	1925	1921	1924	1918	1917	1925	1925	1924	1922	1920	1915	1917	1914	1918	1930	1920	1921	1918	1920	1919	1920	1918	1914	1911	1920	1920	1921	1915	1917	1917	1922	1919	1911	1913	1920	1914	1923	1921	1919	1923	1916	1910	1917	1925	1927	1926	1925	1919	1911	1913	1917	1918	1909	1912	1913	1916	1919	1918	1918	1921	1925	1931	1923	1925	1927	1937	1953	1947	1945	1937	1929	1915	1905	1900	1894	1903	1904	1898	1901	1899	1902	1902	1903	1903	1904	1898	1892	1889	1890	1886	1887	1863	1809	1689	1678	1859	2251	2815	3710	4095	4095	4095	4095	4095	3365	2364	2219	2154	1937	1778	1702	1651	1609	1574	1552	1555	1535	1526	1531	1533	1535	1529	1526	1529	1531	1542	1533	1533	1535	1530	1533	1531	1525	1520	1520	1518	1507	1500	1499	1489	1479	1471	1446	1429	1413	1392	1369	1350	1338	1326	1316	1305	1296	1298	1298	1307	1321	1336	1375	1413	1455	1497	1552	1605	1648	1690	1735	1769	1801	1837	1857	1871	1883	1897	1904	1910	1919	1911	1910	1915	1923	1920	1920	1929	1933	1936	1933	1927	1926	1930	1931	1936	1933	1920	1930	1929	1923	1919	1922	1923	1934	1929	1927	1927	1924	1923	1922	1927	1925	1920	1918	1921	1924	1928	1923	1933	1931	1924	1917	1924	1931	1923	1919	1926	1927	1918	1913	1917	1920	1923	1923	1925	1926	1927	1922	1920	1918	1921	1922	1925	1920	1911	1920	1919	1917	1920	1913	1914	1918	1913	1907	1904	1913	1914	1919	1915	1910	1906	1905	1907	1905	1904	1904	1904	1905	1907	1906	1907	1905	1894	1901	1894	1899	1905	1904	1904	1905	1904	1898	1904	1906	1904	1899	1891	1901	1899	1890	1893	1891	1894	1895	1898	1901	1898	1886	1885	1895	1898	1899	1899	1898	1895	1893	1891	1891	1895	1892	1893	1895	1893	1889	1886	1885	1886	1885	1883	1881	1882	1885	1888	1875	1884	1887	1889	1889	1884	1879	1887	1888	1887	1889	1887	1883	1878	1865	1853	1851	1856	1878	1888	1872	1862	1856	1857	1869	1865	1865	1873	1872	1879	1877	1883	1885	1878	1874	1872	1873	1882	1877	1874	1862	1808	1713	1662	1789	2141	2641	3387	4095	4095	4095	4095	4095	3952	2523	2163	2141	1954	1778	1696	1645	1596	1566	1529	1518	1504	1509	1509	1510	1506	1505	1514	1518	1515	1519	1514	1511	1504	1509	1510	1506	1502	1495	1494	1488	1479	1477	1466	1456	1447	1429	1425	1406	1385	1370	1360	1338	1321	1311	1297	1281	1270	1267	1266	1271	1291	1311	1337	1374	1418	1460	1517	1572	1618	1658	1707	1751	1786	1818	1840	1856	1874	1889	1901	1904	1910	1919	1914	1920	1914	1926	1943	1939	1938	1931	1935	1936	1941	1943	1938	1937	1943	1943	1937	1935	1934	1938	1936	1938	1938	1934	1936	1929	1926	1928	1927	1936	1936	1937	1935	1931	1936	1933	1927	1925	1935	1933	1935	1935	1930	1932	1936	1932	1925	1931	1936	1938	1931	1922	1936	1935	1936	1938	1936	1936	1936	1935	1931	1929	1931	1931	1936	1933	1929	1934	1935	1933	1933	1927	1930	1933	1927	1920	1927	1930	1927	1928	1930	1922	1930	1930	1924	1923	1920	1925	1925	1920	1918	1920	1922	1924	1920	1915	1915	1917	1916	1913	1902	1906	1906	1906	1906	1909	1907	1912	1909	1909	1909	1905	1904	1905	1904	1903	1903	1906	1903	1899	1899	1898	1899	1904	1903	1899	1897	1901	1899	1886	1877	1879	1873	1889	1899	1878	1872	1872	1872	1877	1878	1875	1881	1891	1894	1882	1883	1895	1891	1883	1880	1875	1878	1885	1877	1865	1831	1742	1649	1701	1979	2430	3087	4095	4095	4095	4095	4095	4095	2945	2299	2257	2086	1861	1738	1671	1617	1581	1552	1533	1520	1519	1520	1519	1516	1515	1511	1519	1516	1516	1513	1517	1519	1520	1518	1507	1503	1509	1499	1498	1492	1484	1462	1465	1451	1439	1426	1420	1395	1376	1355	1342	1328	1311	1296	1285	1281	1273	1278	1274	1280	1296	1315	1347	1385	1424	1475	1520	1597	1633	1675	1719	1759	1791	1815	1843	1857	1874	1886	1902	1903	1909	1905	1911	1913	1914	1918	1924	1926	1926	1927	1925	1915	1917	1917	1923	1930	1925	1923	1915	1921	1923	1923	1920	1918	1919	1922	1921	1921	1913	1916	1918	1919	1921	1920	1918];
noise_freq = 50;
noise_amplitude = 1000;
noise = noise_amplitude* sin(2 * pi * noise_freq * t);


data = EKG + noise;
data_sum = 0;
for n = 1:BUFFERSIZE
    data_sum = data_sum + data(n);
    
end

h= fir1(7500, cut_off);
con=conv(data,h);

plot(t,data)
hold
plot(t,conv)

